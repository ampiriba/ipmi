//variables de Estado de Pantalla
int pantalla = 0; // 0: Inicio, 1: reproducción automática, 2: Fin/Reset.

//fuentes y recursos.
PFont fuenteP5;
PImage imgJoker, imgMorgana, imgRyuji, imgAnn, imgFutaba; //sprites.

//variables para interactividad y tiempo.
int personajeSeleccionado = 1; 
int tiempoMuestra = 4000;
int tiempoUltimoCambio = 0;  

//variables para la animación de texto (Fade-in automático)
float alfaTexto = 0;

//variables para la transición estética.
float transicionX;      
boolean ejecutandoTransicion = false;

void setup() {
  size(640, 480);
  
  //carga de imágenes
  imgJoker = loadImage("Joker.png");
  imgMorgana = loadImage("morgana.png");
  imgRyuji = loadImage("ryuji.png");
  imgAnn = loadImage("ann.png");
  imgFutaba = loadImage("futaba.png");

  fuenteP5 = createFont("Impact", 20);
  textFont(fuenteP5);
  
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

//--- PANTALLA 0: MENU DE INICIO ---
void dibujarPantallaInicio() {
  // Fondo rojo base (reemplaza al shape diagonal anterior)
  fill(219, 10, 17); 
  noStroke();
  rect(0, 0, width, height * 0.75);
  
  //título principal estático
  fill(0);
  rectMode(CENTER);
  rect(width * 0.5, height * 0.3, width * 0.6, height * 0.16);
  fill(255);
  textSize(width * 0.06);
  textAlign(CENTER, CENTER);
  text("PHANTOM THIEVES", width * 0.5, height * 0.3);
  
  //botón TAKE YOUR HEART
  if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.68 && mouseY < height * 0.82) {
    fill(255);
    stroke(0);
    strokeWeight(4);
  } else {
    fill(0);
    noStroke();
  }
  
  rectMode(CENTER);
  rect(width * 0.5, height * 0.75, width * 0.36, height * 0.14);
  
  if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.68 && mouseY < height * 0.82) {
    fill(219, 10, 17);
  } else {
    fill(255);
  }
  textSize(width * 0.045);
  textAlign(CENTER, CENTER);
  text("> TAKE YOUR HEART", width * 0.5, height * 0.75);
}

//--- PANTALLA 1: PRESENTACIÓN AUTOMÁTICA ---
void dibujarPantallaPresentacion() {
  rectMode(CORNER);
  
  //fondo base izquierdo
  fill(219, 10, 17);
  noStroke();
  rect(0, 0, width * 0.35, height);
  
  //MENÚ IZQUIERDO
  String[] nombres = {"JOKER", "MORGANA", "SKULL", "PANTHER", "ORACLE"};
  float[] posicionesY = {height * 0.22, height * 0.35, height * 0.48, height * 0.61, height * 0.74};
  
  rectMode(CENTER);
  for (int i = 0; i < 5; i++) {
    int idBoton = i + 1;
    if (personajeSeleccionado == idBoton) {
      fill(255);
      rect(width * 0.13, posicionesY[i], width * 0.22, height * 0.07);
      fill(0);
    } else {
      fill(0);
      rect(width * 0.13, posicionesY[i], width * 0.22, height * 0.07);
      fill(100);
    }
    textAlign(CENTER, CENTER);
    textSize(width * 0.028);
    text(nombres[i], width * 0.13, posicionesY[i]);
  }

  //animación de Fade-In para el texto
  if (alfaTexto < 255) {
    alfaTexto += 8;
  }

  //variables para guardar la info del personaje actual
  String txtNombre = "";
  String txtInfo = "";
  color colorDetalle = color(219, 10, 17);

  if (personajeSeleccionado == 1) {
    if (imgJoker != null) image(imgJoker, width * 0.48, height * 0.12, width * 0.44, height * 0.75);
    txtNombre = "JOKER";
    txtInfo = "Es un estudiante de segundo año transferido a la Academia Shujin, donde fue ubicado para continuar sus estudios debido a su período de prueba por haber sido falsamente acusado de agresión.";
    colorDetalle = color(219, 10, 17);
  } else if (personajeSeleccionado == 2) {
    if (imgMorgana != null) image(imgMorgana, width * 0.53, height * 0.2, width * 0.38, height * 0.66);
    txtNombre = "MORGANA";
    txtInfo = "Es un ser misterioso con vínculos con Mementos. Desconoce su propia identidad y busca respuestas para recuperar sus recuerdos. Su viaje se centra más en aprender a ser él mismo a pesar de su aspecto.";
    colorDetalle = color(255);
  } else if (personajeSeleccionado == 3) {
    if (imgRyuji != null) image(imgRyuji, width * 0.5, height * 0.14, width * 0.42, height * 0.73); 
    txtNombre = "SKULL";
    txtInfo = "Es conocido en la escuela como un estudiante problemático y conflictivo, cuyo mal comportamiento causa todo tipo de problemas a los profesores. Su naturaleza rebelde son las cualidades perfectas.";
    colorDetalle = color(219, 10, 17);
  } else if (personajeSeleccionado == 4) {
    if (imgAnn != null) image(imgAnn, width * 0.5, height * 0.14, width * 0.42, height * 0.73);
    txtNombre = "PANTHER";
    txtInfo = "Tras sentirse abrumada por la culpa debido a su impotencia para proteger a los demás y a sí misma, se sacrificaría para apoyar a sus amigos mientras afrontaba y superaba sus problemas.";
    colorDetalle = color(255);
  } else if (personajeSeleccionado == 5) {
    if (imgFutaba != null) image(imgFutaba, width * 0.55, height * 0.14, width * 0.42, height * 0.73);
    txtNombre = "ORACLE";
    txtInfo = "Con un caso de ansiedad social que raya en la agorafobia, combinado con el trauma de perder a su madre, Futaba está fuertemente desconcertado por el afuera. Se siente sola y cuestiona su vida.";
    colorDetalle = color(219, 10, 17);
  }

  //dibujo de la interfaz de información (Bloque Nombre)
  rectMode(CORNER);
  fill(colorDetalle);
  rect(width * 0.44, height * 0.12, width * 0.28, height * 0.08);
  fill(0);
  textSize(width * 0.04);
  textAlign(LEFT, CENTER);
  text(" " + txtNombre, width * 0.45, height * 0.16);

  //dibujo de la interfaz de información (Bloque Detalle)
  fill(20, 20, 20, 220); 
  stroke(255);
  strokeWeight(2);
  rect(width * 0.42, height * 0.66, width * 0.53, height * 0.28);
  
  fill(255, alfaTexto);
  textSize(width * 0.024);
  textAlign(LEFT, TOP);
  text(txtInfo, width * 0.44, height * 0.68, (width * 0.53) - 24, (height * 0.28) - 24); 
} 

void manejarTemporizador() {
  int tiempoTranscurrido = millis() - tiempoUltimoCambio;
  
  if (tiempoTranscurrido > tiempoMuestra - 300 && !ejecutandoTransicion) {
    ejecutandoTransicion = true;
    transicionX = -width * 1.5; 
  }
  
  if (tiempoTranscurrido >= tiempoMuestra) {
    tiempoUltimoCambio = millis();
    personajeSeleccionado++;
    alfaTexto = 0; 
    
    if (personajeSeleccionado > 5) {
      pantalla = 2; 
    }
  }
}

void dibujarTransicion() {
  if (ejecutandoTransicion) {
    transicionX += width * 0.06;
    
    rectMode(CORNER);
    fill(0);
    noStroke();
    rect(transicionX, 0, width * 0.5, height);
    
    if (transicionX > width * 1.5) {
      ejecutandoTransicion = false;
    }
  }
}

//--- PANTALLA 2: PANTALLA DE FIN / RESET ---
void dibujarPantallaFin() {
  background(10);
  
  rectMode(CORNER);
  fill(219, 10, 17);
  noStroke();
  rect(width * 0.5, 0, width * 0.5, height);
  
  fill(255);
  textSize(width * 0.055);
  textAlign(CENTER, CENTER);
  text("CORAZÓN DESPERTADO", width * 0.5, height * 0.3);
  
  //botón de RESET estático
  rectMode(CENTER);
  if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.52 && mouseY < height * 0.68) {
    fill(255);
    stroke(219, 10, 17);
    strokeWeight(5);
  } else {
    fill(0);
    stroke(255);
    strokeWeight(2);
  }
  
  rect(width * 0.5, height * 0.6, width * 0.37, height * 0.14);
  
  if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.52 && mouseY < height * 0.68) {
    fill(0);
  } else {
    fill(255);
  }
  textSize(width * 0.04);
  textAlign(CENTER, CENTER);
  text("> RESTART CYCLE", width * 0.5, height * 0.6);
}

//--- INTERACTIVIDAD DEL MOUSE ---
void mousePressed() {
  if (pantalla == 0) {
    if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.68 && mouseY < height * 0.82) {
      pantalla = 1;
      tiempoUltimoCambio = millis();
      personajeSeleccionado = 1;
      alfaTexto = 0; 
      ejecutandoTransicion = false;
    }
  } 
  else if (pantalla == 2) {
    if (mouseX > width * 0.32 && mouseX < width * 0.68 && mouseY > height * 0.52 && mouseY < height * 0.68) {
      pantalla = 0;
      personajeSeleccionado = 1;
      alfaTexto = 0;
      tiempoUltimoCambio = millis(); 
    }
  }
}
