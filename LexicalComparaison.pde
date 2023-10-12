/*
Khaireddine SATOURI
Mohamed Hedi KALAI
*/
public class LexicalComparison implements Comparator<Rectangle> {
  public LexicalComparison() {
  }

  public int compare(Rectangle v1, Rectangle v2) {
    if (v1.x > v2.x) {
      return 1;
    } 
    else if (v1.x < v2.x) {
      return -1;
    } 
    else { // x component is the same, check y
      if (v1.y > v2.y) {
        return 1;
      } 
      else {
        return -1;
      }
    }
  }
}
