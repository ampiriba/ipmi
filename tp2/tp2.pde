//variables de Estado de Pantalla
int pantalla = 0; // 0: Inicio, 1: reproducción automática, 2: Fin/Reset.

//fuentes y recursos.
PFont fuenteP5;
PImage fondoEstrellas;
PImage imgJoker, imgMorgana, imgRyuji, imgAnn, imgFutaba; // sprites.

//variables para interactividad y tiempo.
int personajeSeleccionado = 1; 
int tiempoMuestra = 4000;
int tiempoUltimoCambio = 0;  

//variables para la transición estética.
float transicionX;      
boolean ejecutandoTransicion = false;

void setup() {
  size(640, 480);
  

  imgJoker = loadImage("Joker.png");
  imgMorgana = loadImage("morgana.png");
  imgRyuji = loadImage("ryuji.png");
  imgAnn = loadImage("ann.png");
  imgFutaba = loadImage("futaba.png");

  
  textFont(createFont("Impact", 20));
  transicionX = -width;
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
    vertex(width, height * 0.72);
    vertex(0, height * 0.85);
  endShape(CLOSE);
  
  pushMatrix();
    translate(width * 0.5, height * 0.3);
    rotate(radians(-8));
    fill(0);
    rectMode(CENTER);
    rect(0, 0, width * 0.6, height * 0.16);
    fill(255);
    textSize(width * 0.06);
    textAlign(CENTER, CENTER);
    text("PHANTOM THIEVES", 0, -5);
  popMatrix();
  
  pushMatrix();
    translate(width * 0.5, height * 0.75);
    rotate(radians(4));
    
    if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.68 && mouseY < height * 0.82) {
      fill(255);
      stroke(0);
      strokeWeight(4);
    } else {
      fill(0);
      noStroke();
    }
    
    beginShape();
      vertex(-width * 0.18, -height * 0.06);
      vertex(width * 0.16, -height * 0.08);
      vertex(width * 0.18, height * 0.06);
      vertex(-width * 0.16, height * 0.08);
    endShape(CLOSE);
    
    if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.68 && mouseY < height * 0.82) {
      fill(219, 10, 17);
    } else {
      fill(255);
    }
    textSize(width * 0.045);
    text("> TAKE YOUR HEART", 0, 0);
  popMatrix();
}

// --- PANTALLA 1: PRESENTACIÓN AUTOMÁTICA ---
void dibujarPantallaPresentacion() {
  rectMode(CORNER);
  //fondo con cortes diagonales.
  fill(219, 10, 17);
  noStroke();
  beginShape();
    vertex(0, 0);
    vertex(width * 0.42, 0);
    vertex(width * 0.22, height);
    vertex(0, height);
  endShape(CLOSE);
  
  //MENÚ IZQUIERDO: escala vertical adaptable.
  dibujarBotonPersonaje(1, "JOKER", height * 0.22);
  dibujarBotonPersonaje(2, "MORGANA", height * 0.35);
  dibujarBotonPersonaje(3, "SKULL", height * 0.48);
  dibujarBotonPersonaje(4, "PANTHER", height * 0.61);
  dibujarBotonPersonaje(5, "ORACLE", height * 0.74);

  //ÁREA DE RENDERS E INFORMACIÓN.
  if (personajeSeleccionado == 1) {
    if (imgJoker != null) image(imgJoker, width * 0.48, height * 0.12, width * 0.44, height * 0.75);
    mostrarInfoPersonaje("JOKER", "Es un estudiante de segundo año transferido a la Academia Shujin, donde fue ubicado para continuar sus estudios debido a su período de prueba por haber sido falsamente acusado de agresión.", color(219, 10, 17));
  } else if (personajeSeleccionado == 2) {
    if (imgMorgana != null) image(imgMorgana, width * 0.53, height * 0.2, width * 0.38, height * 0.66);
    mostrarInfoPersonaje("MORGANA", "Es un ser misterioso con vínculos con Mementos. Desconoce su propia identidad y busca respuestas para recuperar sus recuerdos. Su viaje se centra más en aprender a ser él mismo a pesar de su aspecto.", color(255));
  } else if (personajeSeleccionado == 3) {
    if (imgRyuji != null) image(imgRyuji, width * 0.5, height * 0.14, width * 0.42, height * 0.73); 
    mostrarInfoPersonaje("SKULL", "Es conocido en la escuela como un estudiante problemático y conflictivo, cuyo mal comportamiento causa todo tipo de problemas a los profesores. Su naturaleza rebelde son las cualidades perfectas.", color(219, 10, 17));
  } else if (personajeSeleccionado == 4) {
    if (imgAnn != null) image(imgAnn, width * 0.5, height * 0.14, width * 0.42, height * 0.73);
    mostrarInfoPersonaje("PANTHER", "Tras sentirse abrumada por la culpa debido a su impotencia para proteger a los demás y a sí misma, se sacrificaría para apoyar a sus amigos mientras afrontaba y superaba sus problemas.", color(255));
  } else if (personajeSeleccionado == 5) {
    if (imgFutaba != null) image(imgFutaba, width * 0.55, height * 0.14, width * 0.42, height * 0.73);
    mostrarInfoPersonaje("ORACLE", "Con un caso de ansiedad social que raya en la agorafobia, combinado con el trauma de perder a su madre, Futaba está fuertemente desconcertado por el afuera. Se siente sola y cuestiona su vida.", color(219, 10, 17));
  }
} 

void manejarTemporizador() {
  int tiempoTranscurrido = millis() - tiempoUltimoCambio;
  
  //inicia el barrido de la transición un poco antes de cambiar de diapositiva.
  if (tiempoTranscurrido > tiempoMuestra - 300 && !ejecutandoTransicion) {
    ejecutandoTransicion = true;
    transicionX = -width * 1.5; 
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
    transicionX += width * 0.06;
    
    fill(0);
    noStroke();
    beginShape();
      vertex(transicionX, 0);
      vertex(transicionX + (width * 0.5), 0);
      vertex(transicionX + (width * 0.12), height);
      vertex(transicionX - (width * 0.38), height);
    endShape(CLOSE);
    
    if (transicionX > width * 1.5) {
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
  textSize(width * 0.055);
  textAlign(CENTER, CENTER);
  text("CORAZÓN DESPERTADO", width * 0.5, height * 0.3);
  
  //botón de RESET.
  pushMatrix();
    translate(width * 0.5, height * 0.6);
    rotate(radians(-3));
    
    if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.52 && mouseY < height * 0.68) {
      fill(255);
      stroke(219, 10, 17);
      strokeWeight(5);
    } else {
      fill(0);
      stroke(255);
      strokeWeight(2);
    }
    
    beginShape();
      vertex(-width * 0.2, -height * 0.06);
      vertex(width * 0.17, -height * 0.08);
      vertex(width * 0.2, height * 0.06);
      vertex(-width * 0.17, height * 0.08);
    endShape(CLOSE);
    
    if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.52 && mouseY < height * 0.68) {
      fill(0);
    } else {
      fill(255);
    }
    textSize(width * 0.04);
    text("> RESTART CYCLE", 0, -5);
  popMatrix();
}

void dibujarBotonPersonaje(int id, String nombre, float yPos) {
  pushMatrix();
    translate(width * 0.13, yPos);
    rotate(radians(-5));
    rectMode(CENTER);
    
    if (personajeSeleccionado == id) {
      fill(255);
      rect(0, 0, width * 0.22, height * 0.07);
      fill(0);
    } else {
      fill(0);
      rect(0, 0, width * 0.22, height * 0.07);
      fill(100);
    }
    
    textAlign(CENTER, CENTER);
    textSize(width * 0.028);
    text(nombre, 0, 0);
  popMatrix();
}

void mostrarInfoPersonaje(String nombre, String info, color colorDetalle) {
  pushMatrix();
    translate(width * 0.44, height * 0.12);
    rotate(radians(3));
    fill(colorDetalle);
    rectMode(CORNER);
    rect(0, 0, width * 0.28, height * 0.08);
    fill(0);
    textSize(width * 0.04);
    textAlign(LEFT, CENTER);
    text(" " + nombre, 10, (height * 0.08) / 2);
  popMatrix();
  
  pushMatrix();
    translate(width * 0.42, height * 0.66);
    rotate(radians(-2));
    fill(20, 20, 20, 220); 
    stroke(255);
    strokeWeight(2);
    rectMode(CORNER);
    rect(0, 0, width * 0.53, height * 0.28);
    
    fill(255);
    textSize(width * 0.024);
    textAlign(LEFT, TOP);
    text(info, 12, 12, (width * 0.53) - 24, (height * 0.28) - 24); 
  popMatrix();
}

// --- INTERACTIVIDAD DEL MOUSE ---
void mousePressed() {
  if (pantalla == 0) {
    //click en TAKE YOUR HEART.
    if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.68 && mouseY < height * 0.82) {
      pantalla = 1;
      tiempoUltimoCambio = millis();
      personajeSeleccionado = 1;
      ejecutandoTransicion = false;
    }
  } 
  else if (pantalla == 2) {
    //click en el botón RESTART CYCLE.
    if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.52 && mouseY < height * 0.68) {
      pantalla = 0;
      personajeSeleccionado = 1;
    }
  }
}
