color [][] tab;
color [][] oldtab;

color rock = color(255, 140, 0);
color paper = color(0, 0, 255);
color scissor = color(255);

int lato = 4;

void setup(){
  
  fullScreen();
  noStroke();
  
  tab = new int [width / lato][height / lato];
  oldtab = new int [width / lato][height / lato];
  
  for(int x = 0; x < width / lato; x++){
    for(int y = 0; y < height / lato; y++){
      
      int r = int(random(3));
      
      switch(r){
        
        case 0:
        tab[x][y] = rock;
        break;
        
        case 1:
        tab[x][y] = paper;
        break;
        
        case 2: 
        tab[x][y] = scissor;
        break;
     
      }
      
      fill(tab[x][y]);
      
      rect(x * lato, y * lato, lato, lato);
      
      oldtab[x][y] = tab[x][y];
    }
  } 
  
}


void draw(){
  
  for(int x = 0; x < width / lato; x++){
    for(int y = 0; y < height / lato; y++){
      
      fill(tab[x][y]);
      rect(x * lato, y * lato, lato, lato);
      
      oldtab[x][y] = tab[x][y];
   
    }
  }
  
  update();
  
}

void update(){
  
  for(int x = 0; x < width / lato; x++){
    for(int y = 0; y < height / lato; y++){
   
       if(oldtab[x][y] == rock){
         
         fight(x, y, paper);
         
       }else if(oldtab[x][y] == paper){
         
         fight(x, y, scissor);
         
       }else if(oldtab[x][y] == scissor){
         
         fight(x, y, rock);
         
       }
    }
  }
  
}

void fight(int x, int y, color enemy){
  
  int counter1 = 0;
  
  for(int lr = x - 1; lr <= x + 1; lr++){
    for(int ud = y - 1; ud <= y + 1; ud++){
     
      if(lr != x || ud != y){
        
        if((lr >= 0 && lr < width / lato) && (ud >= 0 && ud < height / lato)){
          
          if(oldtab[lr][ud] == enemy){
            counter1++;
          }
                   
          //tab[lr][ud] = scissor;
        }else{
          
          int outx = lr;
          int outy = ud;
          
          if(outx < 0){
            outx = (width / lato) - 1;
          } else if(outx >= width / lato){
            outx = 0;
          }
       
          if(outy < 0){
            outy = (height / lato) - 1;
          }else if(outy >= height / lato){
            outy = 0;
          }
      
         if(oldtab[outx][outy] == enemy){
           counter1++;
         }
   
       
        }
        
      }
      
    }
  }
  
  if(counter1 >= 3){
    
    tab[x][y] = enemy;
    
  }else{
    
    tab[x][y] = oldtab[x][y];
 
  }
}
