//make the 8 neighboring dead cells have the same color as center cell when the dead cells become alive as pattern permits.
//same rules for overpopulation/cells dying if same colors
//50/50 chance of a cell taking on a color if 2 different colors neighbor it? ig already taken care of, 1st cell spreads its color

import de.bezier.guido.*;
public boolean pause = false;
public final static int NUM_ROWS = 40;
public final static int NUM_COLS = 40;
private Life[][] buttons;//2d array of Life buttons each representing one cell
private String[][] buffer; //2d array of Strings to store state of buttons array. AR = alive red. AB = alive blue. D = dead.
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );
  buttons = new Life[NUM_ROWS][NUM_COLS];
  buffer = new String[NUM_ROWS][NUM_COLS];
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      buttons[i][j] = new Life(i, j);
    }
  }

}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      if(countNeighbors(i, j) == 3){
        buffer[i][j] = true;
      } else if(countNeighbors(i, j) == 2 && buttons[i][j].getLife() == true){
        buffer[i][j] = true;
      } else {
        buffer[i][j] = false;
      }
      buttons[i][j].draw();
    }
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  if(key == 'p'){
    pause = !pause;
    if(pause == false){
      noLoop();
    }else{
      loop();
    }
  }
}

public void copyFromBufferToButtons() {
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      buttons[i][j].setLife(buffer[i][j]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      buffer[i][j] = buttons[i][j].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  if((r >= 0 && r < NUM_ROWS)&&(c >= 0 && c < NUM_COLS)){
    return true;
  }
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  //top 3
  if(isValid(row-1, col-1) && buttons[row-1][col-1].getLife() == true && buttons[row][col].getColor().equals(buttons[row-1][col-1].getColor())){
    neighbors++;
  }
  if(isValid(row-1, col) && buttons[row-1][col].getLife() == true && buttons[row][col].getColor().equals(buttons[row-1][col].getColor())){
    neighbors++;
  }
  if(isValid(row-1, col+1) && buttons[row-1][col+1].getLife() == true && buttons[row][col].getColor().equals(buttons[row-1][col+1].getColor())){
    neighbors++;
  }
  
  //left and right
  if(isValid(row, col-1) && buttons[row][col-1].getLife() == true && buttons[row][col].getColor().equals(buttons[row][col-1].getColor())){
    neighbors++;
  }
  if(isValid(row, col+1) && buttons[row][col+1].getLife() == true && buttons[row][col].getColor().equals(buttons[row][col+1].getColor())){
    neighbors++;
  }
  
  //bottom
  if(isValid(row+1, col-1) && buttons[row+1][col-1].getLife() == true && buttons[row][col].getColor().equals(buttons[row+1][col-1].getColor())){
    neighbors++;
  }
  if(isValid(row+1, col) && buttons[row+1][col].getLife() == true && buttons[row][col].getColor().equals(buttons[row+1][col].getColor())){
    neighbors++;
  }
  if(isValid(row+1, col+1) && buttons[row+1][col+1].getLife() == true && buttons[row][col].getColor().equals(buttons[row+1][col+1].getColor())){
    neighbors++;
  }
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;
  private String myColor;

  public Life (int row, int col) {
     width = 400/NUM_COLS;
     height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    if(Math.random() < 0.5){
      myColor = "blue";
    }else{
      myColor = "red";
    }
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true){
      fill(0);
    }else{
      //fill( 150 );
      if(myColor.equals("blue")){
        fill(0, 0, 255);
      }
      if(myColor.equals("red")){
        fill(255, 0, 0);
      }
    }
    rect(x, y, width, height);
  }
  public boolean getLife() {
    return alive;
  }
  public void setLife(boolean living) {
    alive = living;
  }
  public String getColor(){
    return myColor;
  }
  public void setColor(String c){
    myColor = c;
  }
}
