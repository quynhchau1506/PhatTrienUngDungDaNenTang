const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bodyParser = require('body-parser');
const dotenv = require('dotenv');
const multer = require('multer');
const cloudinary = require('cloudinary').v2;

dotenv.config();

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Cấu hình Cloudinary
cloudinary.config({
  cloud_name: process.env.CLOUD_NAME,
  api_key: process.env.CLOUDINARY_KEY,
  api_secret: process.env.CLOUDINARY_SECRET,
});

// Kết nối MongoDB
mongoose.connect(process.env.MONGODB_URL)
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.log(err));

// Schema
const UserSchema = new mongoose.Schema({
  username: String,
  email: String,
  password: String,
  image: String,
});
const User = mongoose.model('User', UserSchema);

// Cấu hình multer (lưu tạm file ảnh để upload)
const storage = multer.diskStorage({});
const upload = multer({ storage });

// ======================== API =========================

// Đăng nhập
app.post('/login', async (req, res) => {
  const { email, password } = req.body;
  const user = await User.findOne({ email, password });
  if (!user) {
    return res.status(401).json({ message: 'Sai email hoặc mật khẩu' });
  }
  res.json({ message: 'Đăng nhập thành công', user });
});


// Upload + thêm người dùng
app.post('/users', upload.single('image'), async (req, res) => {
  try {
    let imageUrl = '';

    if (req.file) {
      const uploadRes = await cloudinary.uploader.upload(req.file.path, {
        folder: 'users',
      });
      imageUrl = uploadRes.secure_url;
    }

    const { username, email, password } = req.body;
    const newUser = new User({ username, email, password, image: imageUrl });
    await newUser.save();

    res.json({ message: 'User added successfully', user: newUser });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Upload failed' });
  }
});

// Lấy danh sách
app.get('/users', async (req, res) => {
  const users = await User.find();
  res.json(users);
});


// Sửa
// ✅ Cập nhật user (cho phép sửa ảnh)
app.put('/users/:id', upload.single('image'), async (req, res) => {
  try {
    const { username, email, password } = req.body;
    let imageUrl = req.body.image; // mặc định là ảnh cũ

    // Nếu có upload ảnh mới -> upload lên Cloudinary
    if (req.file) {
      const uploadRes = await cloudinary.uploader.upload(req.file.path, {
        folder: 'users',
      });
      imageUrl = uploadRes.secure_url;
    }

    // Cập nhật DB
    await User.findByIdAndUpdate(req.params.id, {
      username,
      email,
      password,
      image: imageUrl,
    });

    res.json({ message: 'User updated successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Update failed' });
  }
});


// Xoá
app.delete('/users/:id', async (req, res) => {
  await User.findByIdAndDelete(req.params.id);
  res.json({ message: 'User deleted successfully' });
});

// =======================================================

app.listen(process.env.PORT, () => console.log(`Server running on port ${process.env.PORT}`));
