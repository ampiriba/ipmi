//variables - creación
int pantalla = 0; //0 = MainMenu, 1 = Dangopedia, 2 = MenuFin
int PersonajeSeleccionado;
int frameInicioDangopedia = 0; //guarda fotograma en que inicia Dangopedia
PImage ClannadMainMenu, ClannadMenuFin, ClannadMenuDangopedia; //(1)
PImage TomoyaOkazaki, NagisaFurukawa, KyouFujibayashi, KotomiIchinose, TomoyoSakagami; //(2)
PFont FontClannad;
String Tomoya, Nagisa, Kyou, Kotomi, Tomoyo; //texto
float alfa = 0; //transparencia


//variables - asignación
void setup() {
  size(640, 480);
  FontClannad = loadFont("Forsaking.vlw"); //fuente nueva creada
  ClannadMainMenu = loadImage("Clannad.jpg");
  ClannadMenuFin = loadImage("ClannadFin.jpg");
  ClannadMenuDangopedia = loadImage("Dangopedia.jpg");
  TomoyaOkazaki = loadImage("Tomoya.png");
  NagisaFurukawa = loadImage("Nagisa.png");
  KyouFujibayashi = loadImage("Kyou.png");
  KotomiIchinose = loadImage("Kotomi.png");
  TomoyoSakagami = loadImage("Tomoyo.png");
}


//variables - uso
void draw() {
  textFont(FontClannad);

  if (pantalla == 0) { //MainMenu
    image(ClannadMainMenu, 0, 0, width, height); 
    fill(55, 0, 0, 30);
    rect(430, 268, 150, 30); //botón para ir a Dangopedia
  }

  else if (pantalla == 1) { //Dangopedia
    int tiempoDangopedia = frameCount - frameInicioDangopedia;
    
    if (tiempoDangopedia >= 1500) { //llega a los 25 segundos (1500 frames) pasa a M
      pantalla = 2;
    }

    PersonajeSeleccionado = (tiempoDangopedia / 300) % 5; //cada 5 segundos (300 frames) cambia el personaje
    
    int framesDelPersonajeActual = tiempoDangopedia % 300; //De 0 a 299 por personaje
    if (framesDelPersonajeActual < 60) {
      //fade in (primer segundo / 0 a 60 frames) sube transparencia
      alfa = map(framesDelPersonajeActual, 0, 60, 0, 255);
    } 
    else if (framesDelPersonajeActual > 240) {
      //fade out (último segundo / 240 a 300 frames) baja transparencia
      alfa = map(framesDelPersonajeActual, 240, 300, 255, 0);
    } 
    else {
      //255 queda fijo para que el personaje y texto se vea y lea correctamente
      alfa = 255;
    }

    noTint(); //reinicio el estado gráfico
    image(ClannadMenuDangopedia, 0, 0, width, height); 
    stroke(255);
    line(67, 120, 257, 120); 

    if (PersonajeSeleccionado == 0) {
      textSize(12);
      fill(255, alfa); //"alfa" maneja la opacida del texto sobre 255 (color blanco)
      text("Tomoya Okazaki", 68, 115);
      tint(255, alfa);
      
      image(TomoyaOkazaki, 388, 242, 215, 180);

      textSize(20);
      fill(255, alfa);
      text("Tomoya Okazaki", 290, 130);
      textSize(15);
      text("Tomoya es un estudiante de tercer año de 17", 290, 170);
      text("años de la preparatoria Hikarizaka. Siente un", 290, 190);
      text("profundo resentimiento hacia su ciudad", 290, 210);
      text("Hikarizaka, debido a los malos recuerdos que", 290, 230);
      text("vivió allí.", 290, 250);
    }

    else if (PersonajeSeleccionado == 1) {
      textSize(12);
      fill(255, alfa);
      text("Nagisa Furukawa", 68, 115);
      tint(255, alfa);
      
      image(NagisaFurukawa, 470, 242, 130, 180);
      
      textSize(20);
      fill(255, alfa);
      text("Nagisa Furukawa", 290, 130);
      textSize(15);
      text("Nagisa es una chica tímida, siempre", 290, 170);
      text("amable y dulce con los demás. Es altruista", 290, 190);
      text("y humilde, pues tiene baja autoestima y", 290, 210);
      text("valora la felicidad ajena más que la suya.", 290, 230);
      text("Nagisa es ingenua y optimista,", 290, 250);
      text("ya que siempre ve lo bueno", 290, 270);
      text("en todos.", 290, 290);
    }
      
    else if (PersonajeSeleccionado == 2) {
      textSize(12);
      fill(255, alfa);
      text("Kyou Fujibayashi", 68, 115);
      tint(255, alfa);
      
      image(KyouFujibayashi, 470, 242, 130, 180);
      
      textSize(20);
      fill(255, alfa);
      text("Kyou Fujibayashi", 290, 130);
      textSize(15);
      text("Kyou es una chica audaz y agresiva que", 290, 170);
      text("puede ser malhablada, pero también decidida", 290, 190);
      text("y confiable, lo que convierte en un modelo a", 290, 210);
      text("seguir para sus compañeros de cursos", 290, 230);
      text("inferiores.", 290, 250);
    }
      
    else if (PersonajeSeleccionado == 3) {
      textSize(12);
      fill(255, alfa);
      text("Kotomi Ichinose", 68, 115);
      tint(255, alfa);
      
      image(KotomiIchinose, 470, 242, 130, 180);
      
      textSize(20);
      fill(255, alfa);
      text("Kotomi Ichinose", 290, 130);
      textSize(15);
      text("Kotomi es una chica callada y taciturna", 290, 170);
      text("a la que le cuesta relacionarse con los", 290, 190);
      text("demás. Siempre está entre las diez mejores", 290, 210);
      text("alumnas en todas las asignaturas del colegio.", 290, 230);
      text("Kotomi es muy inteligente y", 290, 250);
      text("le gusta leer, incluso libros", 290, 270);
      text("en idiomas extranjeros.", 290, 290);
    }
      
    else if (PersonajeSeleccionado == 4) {
      textSize(12);
      fill(255, alfa);
      text("Tomoyo Sakagami", 68, 115);
      tint(255, alfa);
      
      image(TomoyoSakagami, 470, 242, 130, 180);
      
      textSize(20);
      fill(255, alfa);
      text("Tomoyo Sakagami", 290, 130);
      textSize(15);
      text("Tomoyo es una chica clásica, que siempre se", 290, 170);
      text("comporta con frialdad en cualquier situación.", 290, 190);
      text("Es una chica responsable y trabajadora,", 290, 210);
      text("inteligente y con gran capacidad atlética. A", 290, 230);
      text("pesar de su cáracter fuerte, odia", 290, 250);
      text("iniciar peleas.", 290, 270);
    }
    
    noTint(); //limpia efectos para otras pantallas
  }

  else if (pantalla == 2) {
    noTint();
    image(ClannadMenuFin, 0, 0, width, height);
    fill(55, 0, 0, 30); //botón transparente del reset
    rect(465, 372, 126, 100);
  }
}
  
void mouseClicked() { 
  if (pantalla == 0) {
    if (mouseX > 430 && mouseX < 580 && mouseY > 268 && mouseY < 298) {
      pantalla = 1;
      frameInicioDangopedia = frameCount;
    }
  }

  else if (pantalla == 2) { 
    if (mouseX > 465 && mouseX < 591 && mouseY > 372 && mouseY < 472) {
      pantalla = 0;
    }
  }
}
