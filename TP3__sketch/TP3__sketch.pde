//https://youtu.be/dz0LqFqWrPU

PImage imagenReferencia; 
float factorTamaño = 1.0;
float variacionAleatoria = 0.0;

void setup() {
  size(800, 400);
  noStroke();
  imagenReferencia = loadImage("12.jpg"); 
}

void draw() {
  background(255);
  
  //imágen estática
  image(imagenReferencia, 0, 0, 400, 400); 
  
  //patrón
  dibujarPatronDerecho(400, 0, 400, 400);
}

//función propia que NO retorna valor (void) + parámetros
void dibujarPatronDerecho(float offsetX, float offsetY, float ancho, float alto) {
  
  float pasoY = 12;
 
  for (float y = offsetY + pasoY/2; y < offsetY + alto; y += pasoY) {
    

    float diametro = calcularDiametroFiel(y, alto);
    
    float pasoX = map(y, 0, alto, 11.5, 62.0); 
    pasoY = map(y, 0, alto, 6.0, 46.0);
    
    for (float x = offsetX + pasoX/2; x < offsetX + ancho; x += pasoX) {
      
      //uso de dist() para calcular la cercanía del mouse
      float d = dist(mouseX, mouseY, x, y);
      
      float anguloRotacion = 0.0;
      
      //USO DE CONDICIONALES (if - else)
      if (d < 90) {
        fill(0, 102, 204);
        //INTERACCIÓN: mouse cerca=sombra azul
        anguloRotacion = map(mouseX, 400, width, -0.3, 0.3); 
      } else {
        fill(0);
      }
      
      float diametroFinal = diametro + random(-variacionAleatoria, variacionAleatoria);
      
      //TRANSLATE Y ROTATE
      pushMatrix();
      translate(x, y);
      rotate(anguloRotacion);
      ellipse(0, 0, diametroFinal, diametroFinal); 
      
      popMatrix();
    }
  }
}

//función propia que retorna a un valor (float) + parámetros
float calcularDiametroFiel(float posicionY, float altoMaximo) {
  float tamBase = map(posicionY, 0, altoMaximo, 1.5, 90.0);
  return tamBase * factorTamaño;
}

//eventos de interacción

void mouseMoved() {
  //el movimiento horizontal altera el tamaño solo si está en el lado derecho
  if (mouseX >= 400) {
    factorTamaño = map(mouseX, 400, width, 0.6, 1.4);
  }
}

void mousePressed() {
  //vibración
  if (mouseX >= 400) {
    variacionAleatoria = random(0.5, 3.0);
  }
}

//reiniciar programa
void keyPressed() {
  //apretando r/R se logra resetear el programa
  if (key == 'r' || key == 'R') {
    factorTamaño = 1.0;
    variacionAleatoria = 0.0;
  }
}
