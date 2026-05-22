//variables de Estado de Pantalla
int pantalla = 0; //0: Inicio, 1: reproducción automática, 2: Fin/Reset.

//Fuentes y recursos.
PFont fuenteP5;
PImage fondoEstrellas;
PImage imgJoker, imgMorgana, imgRyuji, imgAnn, imgFutaba; //sprites.

//variables para interactividad y tiempo.
int personajeSeleccionado = 1; 
int tiempoMuestra = 4000;
int tiempoUltimoCambio = 0;  

//variables para la transición estética.
float transicionX = -800;      
boolean ejecutandoTransicion = false;

void setup() {
  size(800, 600);
  
  //inicialización de recursos.
  imgJoker = loadImage("Joker.png");
  imgMorgana = loadImage("morgana.png");
  imgRyuji = loadImage("ryuji.png");
  imgAnn = loadImage("ann.png");
  imgFutaba = loadImage("futaba.png");
  
  textFont(createFont("Impact", 24));
}

void draw() {
  background(0); //fondo negro.
  
  if (pantalla == 0) {
    dibujarPantallaInicio();
  } else if (pantalla == 1) {
    dibujarPantallaPresentacion();
    manejarTemporizador(); //controla el paso automático de diapositivas.
    dibujarTransicion();   //dibuja el corte de transición por encima.
  } else if (pantalla == 2) {
    dibujarPantallaFin();
  }
}

// --- PANTALLA 0: MENU DE INICIO ---
void dibujarPantallaInicio() {
  fill(219, 10, 17); 
  noStroke();
  beginShape();
    vertex(0, 0);
    vertex(width, 0);
    vertex(width, height * 0.75);
    vertex(0, height * 0.9);
  endShape(CLOSE);
  
  pushMatrix();
    translate(width/2 - 100, 180);
    rotate(radians(-8));
    fill(0);
    rectMode(CENTER);
    rect(0, 0, 450, 90);
    fill(255);
    textSize(45);
    textAlign(CENTER, CENTER);
    text("PHANTOM THIEVES", 0, -5);
  popMatrix();
  
  pushMatrix();
    translate(width/2, 450);
    rotate(radians(4));
    
    if (mouseX > width/2 - 120 && mouseX < width/2 + 120 && mouseY > 410 && mouseY < 490) {
      fill(255);
      stroke(0);
      strokeWeight(4);
    } else {
      fill(0);
      noStroke();
    }
    
    beginShape();
      vertex(-140, -35);
      vertex(120, -45);
      vertex(140, 35);
      vertex(-120, 45);
    endShape(CLOSE);
    
    if (mouseX > width/2 - 120 && mouseX < width/2 + 120 && mouseY > 410 && mouseY < 490) {
      fill(219, 10, 17);
    } else {
      fill(255);
    }
    textSize(30);
    text("> TAKE YOUR HEART", 0, 0);
  popMatrix();
}

// --- PANTALLA 1: PRESENTACIÓN AUTOMÁTICA ---
void dibujarPantallaPresentacion() {
  //fondo con cortes diagonales.
  fill(219, 10, 17);
  noStroke();
  beginShape();
    vertex(0, 0);
    vertex(width * 0.4, 0);
    vertex(width * 0.2, height);
    vertex(0, height);
  endShape(CLOSE);
  
  //MENÚ IZQUIERDO: se iluminan solos según el personaje activo en el tiempo.
  dibujarBotonPersonaje(1, "JOKER", 150);
  dibujarBotonPersonaje(2, "MORGANA", 230);
  dibujarBotonPersonaje(3, "SKULL", 310);
  dibujarBotonPersonaje(4, "PANTHER", 390);
  dibujarBotonPersonaje(5, "ORACLE", 470);

  //ÁREA DE RENDERS E INFORMACIÓN.
  if (personajeSeleccionado == 1) {
    image(imgJoker, 400, 100, 350, 450);
    mostrarInfoPersonaje("JOKER", "Es un estudiante de segundo año transferido a la Academia Shujin, donde fue ubicado para continuar sus estudios debido a su período de prueba por haber sido falsamente acusado de agresión.", color(219, 10, 17));
  } else if (personajeSeleccionado == 2) {
    image(imgMorgana, 450, 150, 300, 400);
    mostrarInfoPersonaje("MORGANA", "Es un ser misterioso con vínculos con Mementos. Desconoce su propia identidad y busca respuestas para recuperar sus recuerdos. Su viaje se centra más en aprender a ser él mismo a pesar de su aspecto y de cómo lo perciben los demás.", color(255));
  } else if (personajeSeleccionado == 3) {
    image(imgRyuji, 420, 110, 340, 440); 
    mostrarInfoPersonaje("SKULL", "Es conocido en la escuela como un estudiante problemático y conflictivo, cuyo mal comportamiento causa todo tipo de problemas a los profesores. Su naturaleza rebelde, traviesa y desobediente son las cualidades perfectas para ser un Ladrón Fantasma.", color(219, 10, 17));
  } else if (personajeSeleccionado == 4) {
    image(imgAnn, 420, 110, 340, 440);
    mostrarInfoPersonaje("PANTHER", "Tras sentirse abrumada por la culpa debido a su impotencia para proteger a los demás y a sí misma, se sacrificaría para apoyar a sus amigos mientras afrontaba y superaba sus problemas y prometía no volver a ser como antes.", color(255));
  } else if (personajeSeleccionado == 5) {
    image(imgFutaba, 500, 110, 340, 440);
    mostrarInfoPersonaje("ORACLE", "Con un caso de ansiedad social que raya en la agorafobia, combinado con el trauma de perder a su madre, Futaba está fuertemente desconcertado por el afuera. Futaba se siente sola, vive sin pasión y entusiasmo, cuestiona el punto de su vida.", color(219, 10, 17));
  }
} 

void manejarTemporizador() {
  int tiempoTranscurrido = millis() - tiempoUltimoCambio;
  
  //Inicia el barrido de la transición un poco antes de cambiar de diapositiva.
  if (tiempoTranscurrido > tiempoMuestra - 300 && !ejecutandoTransicion) {
    ejecutandoTransicion = true;
    transicionX = -1200; 
  }
  
  //cambio exacto de personaje.
  if (tiempoTranscurrido >= tiempoMuestra) {
    tiempoUltimoCambio = millis();
    personajeSeleccionado++;
    
    if (personajeSeleccionado > 5) {
      pantalla = 2; 
    }
  }
}

void dibujarTransicion() {
  if (ejecutandoTransicion) {
    transicionX += 45;
    
    fill(0);
    noStroke();
    beginShape();
      vertex(transicionX, 0);
      vertex(transicionX + 400, 0);
      vertex(transicionX + 100, height);
      vertex(transicionX - 300, height);
    endShape(CLOSE);
    
    if (transicionX > width + 400) {
      ejecutandoTransicion = false;
    }
  }
}

// --- PANTALLA 2: PANTALLA DE FIN / RESET ---
void dibujarPantallaFin() {
  background(10);
  
  fill(219, 10, 17);
  beginShape();
    vertex(width, height);
    vertex(width * 0.3, height);
    vertex(width * 0.6, 0);
    vertex(width, 0);
  endShape(CLOSE);
  
  fill(255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text("CORAZÓN DESPERTADO", width * 0.5, height * 0.3);
  
  //botón de RESET
  pushMatrix();
    translate(width/2, height * 0.6);
    rotate(radians(-3));
    
    if (mouseX > width/2 - 120 && mouseX < width/2 + 120 && mouseY > height * 0.6 - 40 && mouseY < height * 0.6 + 40) {
      fill(255);
      stroke(219, 10, 17);
      strokeWeight(5);
    } else {
      fill(0);
      stroke(255);
      strokeWeight(2);
    }
    
    beginShape();
      vertex(-130, -35);
      vertex(110, -45);
      vertex(130, 35);
      vertex(-110, 45);
    endShape(CLOSE);
    
    if (mouseX > width/2 - 120 && mouseX < width/2 + 120 && mouseY > height * 0.6 - 40 && mouseY < height * 0.6 + 40) {
      fill(0);
    } else {
      fill(255);
    }
    textSize(28);
    text("> RESTART CYCLE", 0, -5);
  popMatrix();
}

void dibujarBotonPersonaje(int id, String nombre, float yPos) {
  pushMatrix();
    translate(120, yPos);
    rotate(radians(-5));
    
    if (personajeSeleccionado == id) {
      fill(255);
      rect(0, 0, 180, 40);
      fill(0);
    } else {
      fill(0);
      rect(0, 0, 180, 40);
      fill(100);
    }
    
    textAlign(CENTER, CENTER);
    textSize(20);
    text(nombre, 0, 0);
  popMatrix();
}

void mostrarInfoPersonaje(String nombre, String info, color colorDetalle) {
  pushMatrix();
    translate(width * 0.45, 80);
    rotate(radians(3));
    fill(colorDetalle);
    rectMode(CORNER);
    rect(0, 0, 200, 45);
    fill(0);
    textSize(28);
    textAlign(LEFT, CENTER);
    text(" " + nombre, 10, 20);
  popMatrix();
  
  pushMatrix();
    translate(width * 0.42, 420);
    rotate(radians(-2));
    fill(20, 20, 20, 220); 
    stroke(255);
    strokeWeight(2);
    rect(0, 0, 400, 130);
    
    fill(255);
    textSize(15);
    textAlign(LEFT, TOP);
    text(info, 15, 15, 370, 100); 
  popMatrix();
}

// --- INTERACTIVIDAD DEL MOUSE ---
void mousePressed() {
  if (pantalla == 0) {
    // Clic en TAKE YOUR HEART 
    if (mouseX > width/2 - 120 && mouseX < width/2 + 120 && mouseY > 410 && mouseY < 490) {
      pantalla = 1;
      tiempoUltimoCambio = millis();
      personajeSeleccionado = 1;
    }
  } 
  else if (pantalla == 2) {
    //Click en el botón RESTART CYCLE
    if (mouseX > width/2 - 120 && mouseX < width/2 + 120 && mouseY > height * 0.6 - 40 && mouseY < height * 0.6 + 40) {
      pantalla = 0;
      personajeSeleccionado = 1;
    }
  }
}
