PImage miImagen;

void setup() {
  size(800, 400);
  miImagen = loadImage("image0.jpg");
  rectMode(CORNER);
  noStroke();
}
  
void draw() {
  image(miImagen, 0, 0, 200, 400);
  fill(#A3B8B8); 
  rect(width/ 2 - 200, 0, width, height);
  
  //calle
  fill(30);
  rect(0, height - 50, width, 50);
  //time square
  fill(#A39A99);
  rect(330, height - 330, 80, 280);
  
  //antena
  fill(#A39A99);
  rect(355, 45, height - 370, 50);
  fill(#A39A99);
  rect(367, 15, height - 395, 40);
  fill(#A39A99);
  rect(369, 6, height - 399, 40);
  
  //cuadrados superiores
  fill(#A39A99);
  rect(340, 65, height - 340, 60);
  fill(#A39A99);
  rect(345, 60, height - 350, 30);
  
  //cuadrados inferiores
  fill(#ABA2A1); //01
  rect(320, 280, height - 300, 70);
  fill(#ABA2A1); //02
  rect(310, 300, height - 280, 50);
  fill(#A69E9D); //03 mini
  rect(355, 230, height - 370, 70);
  fill(#ABA2A1); //04 largo A
  rect(325, 100, height - 370, 240);
  fill(#ABA2A1); //04 largo B
  rect(385, 100, height - 370, 240);
  
  //mini arco
  fill(#ABA2A1);
  rect(405, 75, height - 470, 10);
  fill(#ABA2A1);
  rect(335, 80, height - 380, 30);
  fill(#ABA2A1);
  rect(385, 80, height - 380, 30);
  
  //mini ventanales
  fill(#000000);
  rect(362, 90, height - 397, 7);
  rect(369, 90, height - 397, 7);
  rect(376, 90, height - 397, 7);
  
  //lineas horizontales, ventanas
  fill(#C8C9C1); //izquierda
  rect(330, 100, height - 399, 200);
  rect(335, 100, height - 399, 200);
  rect(340, 75, height - 399, 225);
  rect(345, 75, height - 399, 225);
  rect(350, 75, height - 399, 225);
  rect(355, 75, height - 399, 225);
  fill(#C8C9C1); //derecha
  rect(410, 100, height - 399, 200);
  rect(405, 100, height - 399, 200);
  rect(400, 75, height - 399, 225);
  rect(395, 75, height - 399, 225);
  rect(390, 75, height - 399, 225);
  rect(385, 75, height - 399, 225);
  
  //lineas verticales, ventanas
  fill(#C8C9C1); 
  rect(330, 100, height - 320, 2);
  rect(325, 110, height - 310, 2);
  rect(325, 120, height - 310, 2);
  rect(325, 130, height - 310, 2);
  rect(325, 140, height - 310, 2);
  rect(325, 150, height - 310, 2);
  rect(325, 160, height - 310, 2);
  rect(325, 170, height - 310, 2);
  rect(325, 180, height - 310, 2);
  rect(325, 190, height - 310, 2); 
  rect(325, 200, height - 310, 2);  
  rect(325, 210, height - 310, 2);
  rect(325, 220, height - 310, 2);
  rect(325, 230, height - 310, 2);
  rect(325, 240, height - 310, 2);
  rect(325, 250, height - 310, 2);
  rect(325, 260, height - 310, 2);
  rect(325, 270, height - 310, 2); 
  rect(320, 280, height - 299, 2); 
  rect(320, 290, height - 299, 2);
  
  //entrada
  fill(#B7B8AE);
  rect(356, 315, height - 370, 15);
  rect(320, 330, height - 300, 20);
}
