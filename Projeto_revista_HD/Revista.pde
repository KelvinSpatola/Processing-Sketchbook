class Revista {
  ArrayList<Page> pageList = new ArrayList();

  int pageNum;
  boolean goNextPage, goPreviousPage, insideIndice;

  Button previousPage, nextPage, videoBtn;
  boolean isClicked = false;

  Button[] indexesBtns = new Button[15];
  String[] pageNames = {"Editorial", "Prólogo", "Video (Intro)", "Ernst Keller", "Armin Hofmann", "Sistemas de Grelha", "Emil Ruder", 
    "Akzidenz Grotesk", "Max Bill", "Adrian Frutiger", "Univers", "Joseph Muller Brockman", "Die Neue GrafiK", "Max Miedinger", "Helvetica"};

  Revista(PApplet app) {
    pageList.add(new Capa(app, 1, "/paginas/capaPrincipal.png"));//***********
    pageList.add(new Editorial(app, 2, "/paginas/editorial.png"));
    pageList.add(new Indice(app, 3, "/paginas/Fundo1.png"));//***********
    pageList.add(new Page(app, 4, "/paginas/prologo.jpg")); // Prologo
    pageList.add(new Prologo2(app, 5, "/paginas/Fundo1.png", "/videos/International Typographic Style.mp4")); // Prologo 2 (video)
    pageList.add(new Ernst(app, 6, "/paginas/Ernst_Keller.jpg", "/videos/Ernst_Keller.mp4", width - 200, 200, 50, 50)); // Ernert Keller
    pageList.add(new Page(app, 7, "/paginas/Armin_Hofmann.png")); // Armin_Hofmann  Emil_Ruder.jpg
    pageList.add(new Page(app, 8, "/paginas/Emil_Ruder.jpg")); // Emil_Ruder
    pageList.add(new Page(app, 9, "/paginas/Sistemas_de_Grelha.png")); // Sistema de grelha
    pageList.add(new Akzidenz(app, 10, "/paginas/Akzidenz_Grotesk.png", "/paginas/Akzidenz_Grotesk_sample.png", 210, height/2+30, 150, 180)); // Akzidenz_Grotesk
    pageList.add(new Page(app, 11, "/paginas/Max_Bill.png")); // Max_Bill
    pageList.add(new Page(app, 12, "/paginas/Adrian_Frutiger.png")); // Adrian_Frutiger
    pageList.add(new Akzidenz(app, 13, "/paginas/Univers.png", "/paginas/Univers_sample.png", width-215, height/2+40, 230, 210)); // Univers
    pageList.add(new Ernst(app, 14, "/paginas/Josef_Muller.png", "/videos/Josef_Muller.webm", width/2 - 100, 200, 50, 50)); // Josef_Muller (video)
    pageList.add(new Page(app, 15, "/paginas/Die_Neue.png")); // Die_Neue
    pageList.add(new Page(app, 16, "/paginas/Max_Miedinger.png")); // Max_Miedinger
    pageList.add(new LastPage(app, 17, "/paginas/Helvetica.png")); // Helvetica

    previousPage = new Button(app, 50, 50, 100, 100);
    previousPage.setBackgroundImage("/botoes/previousSmall.png", "/botoes/previousLarge.png");

    nextPage = new Button(app, width-50, 50, 100, 100);
    nextPage.setBackgroundImage("/botoes/nextSmall.png", "/botoes/nextLarge.png");

    float hh = height - 200;
    for (int i = 0; i < indexesBtns.length; i++) {
      indexesBtns[i] = new Button(app, width/2, (int)(100 + hh/indexesBtns.length * i), 200, 50);
      indexesBtns[i].setBackgroundColor(color(255, 0));
      indexesBtns[i].setText(pageNames[i], pageNames[i], 30, color(0), color(#FF2121));
    }

    pageNum = 0;
  }

  void ler() {

    // NEXT PAGE
    if (goNextPage && pageNum != pageList.size()-1) {
      pageList.get(pageNum).transitionNext();
      pageList.get(pageNum+1).display();
      if (pageList.get(pageNum).transitionFinished) {
        goNextPage = false;
        pageList.get(pageNum).resetPage();
        if (pageNum == pageList.size()-1) pageNum = pageList.size()-1;
        else pageNum++;
      }
      // PREVIOUS PAGE
    } else if (goPreviousPage && pageNum != 0) {
      pageList.get(pageNum).transitionPrevious();
      pageList.get(pageNum-1).display();
      if (pageList.get(pageNum).transitionFinished) {
        goPreviousPage = false;
        pageList.get(pageNum).resetPage();
        if (pageNum == 0) pageNum = 0;
        else pageNum--;
      }
    }

    pageList.get(pageNum).display();

    if (pageNum == 2) { // INDICE
      for (int i = 0; i < indexesBtns.length; i++) {
        indexesBtns[i].display();
      }
    }

    previousPage.display();
    nextPage.display();
  }

  void mudarPagina() {   
    if (isInsideLeft()) goPreviousPage = true;
    else goPreviousPage = false;

    if (isInsideRight()) goNextPage = true;
    else goNextPage = false;
  }

  boolean isInsideRight() {
    return (mouseX > width-100 && mouseY < 100);
  }
  boolean isInsideLeft() {
    return (mouseX < 100 && mouseY < 100);
  }
  void keyPressedContext() {
    if (key == 'i' || key == 'I') pageNum = 2;
  }
  void mousePressedContext() {
    if (pageNum == 2) { // INDICE
      for (int i = 0; i < indexesBtns.length; i++) {
        if (indexesBtns[0].isClicked()) pageNum = 1;
        else if (indexesBtns[1].isClicked()) pageNum = 3;
        else if (indexesBtns[2].isClicked()) pageNum = 4;
        else if (indexesBtns[3].isClicked()) pageNum = 5;
        else if (indexesBtns[4].isClicked()) pageNum = 6;
        else if (indexesBtns[5].isClicked()) pageNum = 7;
        else if (indexesBtns[6].isClicked()) pageNum = 8;
        else if (indexesBtns[7].isClicked()) pageNum = 9;
        else if (indexesBtns[8].isClicked()) pageNum = 10;
        else if (indexesBtns[9].isClicked()) pageNum = 11;
        else if (indexesBtns[10].isClicked()) pageNum = 12;
        else if (indexesBtns[11].isClicked()) pageNum = 13;
        else if (indexesBtns[12].isClicked()) pageNum = 14;
        else if (indexesBtns[13].isClicked()) pageNum = 15;
        else if (indexesBtns[14].isClicked()) pageNum = 16;
        else if (indexesBtns[15].isClicked()) pageNum = 17;
      }
    }

    if (pageNum == 4) { // prologo 2
      if (pageList.get(4).videoBtn.isClicked()) {
        pageList.get(4).isClicked = true;
        pageList.get(4).mov.play();
      }
    } else if (pageNum == 5) { // Ernst video
      if (pageList.get(5).videoBtn.isClicked()) {
        pageList.get(5).isClicked = true;
        pageList.get(5).mov.play();
      }
    } else if (pageNum == 9) { // Ernst video
      if (pageList.get(9).videoBtn.isClicked()) {
        pageList.get(9).isClicked = true;
      } else pageList.get(9).isClicked = false;
    } else if (pageNum == 12) { // Ernst video
      if (pageList.get(12).videoBtn.isClicked()) {
        pageList.get(12).isClicked = true;
      } else pageList.get(12).isClicked = false;
    } else if (pageNum == 13) { // Ernst video
      if (pageList.get(13).videoBtn.isClicked()) {
        pageList.get(13).isClicked = true;
        pageList.get(13).mov.play();
      }
    }
  }
}
