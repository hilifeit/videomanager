List<VideoQualityItem> items = [
  VideoQualityItem(text: '120p', id: 0),
  VideoQualityItem(text: '360p', id: 1),
  VideoQualityItem(text: '720p', id: 2),
  VideoQualityItem(text: '1080p', id: 3),
];

class VideoQualityItem {
  VideoQualityItem({required this.text, required this.id});
  String text;
  int id;
}
