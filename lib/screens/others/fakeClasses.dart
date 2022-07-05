final window = Window._();

class Window {
  Window._();
  Document get document => Document();
}

class Document {
  Stream<MouseEvent> get onContextMenu =>
      Stream<MouseEvent>.value(MouseEvent(''));
}

class MouseEvent {
  MouseEvent(String data);
  preventDefault() {}
}
