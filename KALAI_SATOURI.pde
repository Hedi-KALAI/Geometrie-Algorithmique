/*
Khaireddine SATOURI
Mohamed Hedi KALAI
*/

import java.util.Collections;
import java.util.Comparator;

int N=1000, taillemoy=10;
PVector tabvec[] = new PVector[N];
ArrayList<Rectangle> rects = new ArrayList<Rectangle>();

//remplissage de la liste de rectangles
void ajout_rect(PVector[] rec) { 
  for (int i=0; i<N; i++) {
    rects.add(new Rectangle(rec[i].x, rec[i].y, random(taillemoy/10, taillemoy*taillemoy/10), random(taillemoy/10, taillemoy*taillemoy/10)));
  }
}

//*********************************************************************
void bruteforce() {
  for (Rectangle i : rects) {
    for (Rectangle j : rects) {
      if (i !=j) { //pour ne pas considérer le triangle actuel i en collision avec lui meme
      //if not (x.top_right_i<=x.top_left_j or the opposite or y.bottom_i<=y.bottom_j or the opposite)
        if (!(i.x+i.largeur<=j.x || j.x+j.largeur<=i.x || i.y+i.hauteur<=j.y || j.y+j.hauteur<=i.y)) {
          stroke(255, 0, 0);
          rect(j.x, j.y, j.largeur, j.hauteur);
          rect(i.x, i.y, i.largeur, i.hauteur);
        }
      }
    }
  }
}
//*********************************************************************


//*********************************************************************
void SweepLine() {
  for (int i=0;i<N;i++) {
    for (int j=i+1;j<N;j++) {
        if (rects.get(i).x+rects.get(i).largeur>=rects.get(j).x) { // if top_right_i>=top_left_j
        //on vérifie que il y'a une collision par rapport à l'axe des ordonné
          if(!(rects.get(i).y>rects.get(j).y+rects.get(j).hauteur)&& !(rects.get(j).y>rects.get(i).y+rects.get(i).hauteur)){
          stroke(255, 0, 0);
          rect(rects.get(j).x, rects.get(j).y, rects.get(j).largeur, rects.get(j).hauteur);
          rect(rects.get(i).x, rects.get(i).y, rects.get(i).largeur, rects.get(i).hauteur);
          }
        }
      }
    
  }
}
//*********************************************************************


//*********************************************************************
void DivideAndConquer(int f, int d) {
    if (f-d<10){
      //meme fonctionnement que le BruteForce
   for (Rectangle i : rects) {
    for (Rectangle j : rects) {
      if (i !=j) {         //pour ne pas considérer le triangle actuel i en collision avec lui meme
      //if not (x.top_right_i<=x.top_left_j or the opposite or y.bottom_i<=y.bottom_j or the opposite)
        if (!(i.x+i.largeur<=j.x || j.x+j.largeur<=i.x || i.y+i.hauteur<=j.y || j.y+j.hauteur<=i.y)) {
          stroke(255, 0, 0);
          rect(j.x, j.y, j.largeur, j.hauteur);
          rect(i.x, i.y, i.largeur, i.hauteur);
        }
      }
    }
  }    
   
  }
    else{
      //récursivité du fonctionnement pour la moitié de la taille
        DivideAndConquer(d,(d+f)/2);
        DivideAndConquer((d+f)/2,f);
  }
}
//*********************************************************************


void setup() {
  size(500, 500);
  for (int i=0; i<N; i++) {
    tabvec[i] = new PVector(random(width), random(height));
  }

  ajout_rect(tabvec);
}

void draw() {
  background(255);
  stroke(0);
  strokeWeight(1);
  noFill();

  for (Rectangle rect : rects) {
    rect(rect.x, rect.y, rect.largeur, rect.hauteur);
  }

  //-------------------BruteForce----------------------
  
   int debut1 = millis();
   bruteforce();
   int fin1 = millis();
   println("Pour nombres de rectangles N= ", N, "BruteForce time : ", str(fin1-debut1)+"ms\t"); 
   
   

  //-----------------Sweep-Line-------------------------
  
  Collections.sort(rects, new LexicalComparison());  
  int debut2 = millis();
  SweepLine();
  int fin2= millis();
  println("Pour nombres de rectangles N= ", N, "Sweep-Line time : ", str(fin2-debut2)+"ms\t"); 
  
  
  //-----------------DivideAndConquer---------------------
 
  Collections.sort(rects, new LexicalComparison());  
  int debut3 = millis();
   DivideAndConquer(0, N);
  int fin3 = millis();
   println("Pour nombres de rectangles N= ", N, "Divide and conquer time : ", str(fin3-debut3)+"ms\t"); 
   

  noLoop();
}
