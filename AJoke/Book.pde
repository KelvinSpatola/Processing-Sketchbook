class Book {
  ArrayList<Page> pageList = new ArrayList();

  int pageNum;
  boolean goNextPage, goPreviousPage;

  AudioPlayer backgroundSong;

  Book() {
    pageList.add(new Page_0(0));
    pageList.add(new Page_1(1));
    pageList.add(new Page_2(2));
    pageList.add(new Page_3(3));
    pageList.add(new Page_4(4));
    pageList.add(new Page_5(5));
    pageList.add(new Page_6(6));
    pageList.add(new Page_7(7));
    pageList.add(new Page_8(8));
    pageList.add(new Page_9(9));
    pageList.add(new Page_10(10));

    backgroundSong = theMinim.loadFile("\\other\\melodia_fundo.mp3");
    backgroundSong.loop();

    pageNum = 0;
  }

  void read() {
    pageList.get(pageNum).display();
    if (pageList.get(pageNum).contextCompleted()) {
      pageList.get(pageNum).reset();
      if (pageNum >= pageList.size()-1) {
        pageNum = 0;
        for(Page p : pageList ) p.reset();
      } else pageNum++;
    }
  }

  void changePage() {
    if (keyCode == LEFT) {
      if (pageNum <= 0) pageNum = 0;
      else {
        pageList.get(pageNum).reset();
        pageNum--;
      }
    }
    if (keyCode == RIGHT) {
      if (pageNum >= pageList.size()-1) pageNum = pageList.size()-1;
      else {
        pageList.get(pageNum).reset();
        pageNum++;
      }
    }
  }

  void mouseDragged() {
    for (Page p : pageList) p.mouseDragged();
  }

  void mousePressed() {
    for (Page p : pageList) p.mousePressed();
  }

  void mouseReleased() {
    for (Page p : pageList) p.mouseReleased();
  }
}
