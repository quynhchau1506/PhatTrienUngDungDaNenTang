import 'story.dart';

class StoryBrain {
  int _storyNumber = 0;

  final List<Story> _storyData = [
    Story(
      storyTitle: 'Bạn đang lái xe trong rừng thì lốp xe nổ. '
          'Bạn mở cốp xe nhưng không có bánh dự phòng. '
          'Bỗng có một người đàn ông lạ mặt tiến lại gần và hỏi bạn có cần giúp đỡ không.',
      choice1: 'Tôi sẽ mời ông ấy đi nhờ.',
      choice2: 'Tốt hơn hết là không nói chuyện, tôi sợ lắm.',
    ),
    Story(
      storyTitle: 'Người đàn ông bắt đầu kể về gia đình ông ta khi bạn đang lái xe. '
          'Bỗng ông ta rút dao ra!',
      choice1: 'Tôi hỏi ông ta muốn gì.',
      choice2: 'Tôi tăng tốc và cố thoát khỏi ông ta.',
    ),
    Story(
      storyTitle: 'Xe bạn lao khỏi đường và rơi xuống vực. '
          'May mắn thay bạn thoát được và sống sót. Hết truyện!',
      choice1: 'Khởi động lại câu chuyện',
      choice2: '',
    ),
    Story(
      storyTitle: 'Bạn từ chối sự giúp đỡ của người lạ và đi bộ một mình trong rừng. '
          'Bạn tìm thấy một ngôi nhà nhỏ với ánh sáng le lói.',
      choice1: 'Gõ cửa xin giúp đỡ.',
      choice2: 'Đi tiếp trong bóng tối.',
    ),
    Story(
      storyTitle: 'Một bà cụ mở cửa và mời bạn vào. '
          'Bà đưa cho bạn một tách trà... và bạn bắt đầu cảm thấy buồn ngủ.',
      choice1: 'Khởi động lại câu chuyện',
      choice2: '',
    ),
    Story(
      storyTitle: 'Bạn đi tiếp và bị lạc mãi mãi trong rừng. '
          'Không ai còn thấy bạn nữa. Hết truyện!',
      choice1: 'Khởi động lại câu chuyện',
      choice2: '',
    ),
  ];

  String getStory() => _storyData[_storyNumber].storyTitle;
  String getChoice1() => _storyData[_storyNumber].choice1;
  String getChoice2() => _storyData[_storyNumber].choice2;

  void nextStory(int choiceNumber) {
    if (_storyNumber == 0 && choiceNumber == 1) {
      _storyNumber = 1;
    } else if (_storyNumber == 0 && choiceNumber == 2) {
      _storyNumber = 3;
    } else if (_storyNumber == 1 && choiceNumber == 1) {
      _storyNumber = 2;
    } else if (_storyNumber == 1 && choiceNumber == 2) {
      _storyNumber = 5;
    } else if (_storyNumber == 3 && choiceNumber == 1) {
      _storyNumber = 4;
    } else if (_storyNumber == 3 && choiceNumber == 2) {
      _storyNumber = 5;
    } else if (_storyNumber == 2 || _storyNumber == 4 || _storyNumber == 5) {
      restart();
    }
  }

  void restart() {
    _storyNumber = 0;
  }

  bool buttonShouldBeVisible() {
    // Ẩn nút 2 khi là story kết thúc
    return !(_storyNumber == 2 || _storyNumber == 4 || _storyNumber == 5);
  }
}
