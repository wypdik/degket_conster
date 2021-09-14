import ddf.minim.*;

int scene = 0;
float p_img_y = 450;
float e_img_y = 220;
float move = 0.1;
Boolean damage_e = false;
Boolean damage_p = false;
Boolean m_judge = false;
Boolean perfect = false;
Boolean great = false;
Boolean good = false;
String command = "";
String waza1 = "↑→↓→";
String waza2 = "←←↑↑";
String waza3 = "↓↓→↑";
int damage = 0;
int damage_dis = 0;
int d_cnt = 0;
int t_cnt = 0;
int cmd_cnt = 0;
int color_num = 0;
int judge_y = 0;
int play_cnt = 0;
int enemy_yb ;
PImage ply_img;
PImage ene_img;
PImage r1, r2, r3, r4;
PImage g1, g2, g3, g4;
PImage b1, b2, b3, b4;
PImage ex_r, ex_g, ex_b;
PImage bg, chose_bg, logo, tit;
PImage[] imgs = new PImage[9];
int slide = 0;
int stage = 1;
int max = 5; 

int[]notes=new int[]{0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1};
float bpm=142;
float[]notes_y=new float[notes.length];
boolean[]notes_hit=new boolean[notes.length];

Player player;
Enemy enemy;
Minim mn;
AudioPlayer audio;

class Player {
  int hp = 100;

  void display() {
    float hp_height = map(hp, 0, 100, 0, 245);
    strokeWeight(1);
    image(ply_img, 250, p_img_y);
    strokeWeight(5);
    fill(255);
    rect(225, 730, 250, 25);
    noStroke();
    fill(0, 255, 0);
    rect(228, 733, hp_height, 20);
    stroke(0);
    fill(0);
    textSize(30);
    text("HP", 225, 730);
  }
}

class Enemy {
  int hp = 100;
  void display() {
    float hp_height = map(hp, 0, 100, 0, 245);
    strokeWeight(5);
    image(ene_img, 450, e_img_y, 300, 250);
    strokeWeight(5);
    fill(255);
    rect(475, 190, 250, 25);
    noStroke();
    fill(255, 0, 0);
    rect(478, 193, hp_height, 20);
    stroke(0);
    fill(0);
    text("HP", 478, 255);
  }
}

void title() {

  image(tit, 0, 0);
  image(logo, 10, 30);
  if (mouseX>=width/2-75&&mouseX<=width/2+75&&mouseY>=height-50&&mouseY<=height&&mousePressed) {
    exit();
  }
}

void howto() {
  background(255);
  fill(255);
  image(imgs[slide], 0, 0);
  //右の三角形
  if (slide <= imgs.length-2) {
    triangle(width*8.5/10, height*8/10, width*8.5/10, height*9/10, width*9.2/10, height*25.5/30);
  }

  if (slide >= 1) {
    //左の三角形
    triangle(width*1.5/10, height*8/10, width*1.5/10, height*9/10, width*0.8/10, height*25.5/30);
  }

  if (width*2/3+50 <= mouseX && mouseX <= width*2/3+50 + width/4 && height/24-20 <= mouseY && mouseY <= height/24-20+100) {
    fill(#F797C4);
  }
  rect(width*2/3+50, height/24-20, width/4, height/8);
  fill(0);
  textSize(32);
  text("home", width*3/4+44, height/9-15);
}

void ChoseStages() {
  noFill();
  background(200);
  image(chose_bg, 0, 0);

  //ステージ画面
  rect(width/4 - width*5/48, height/4, width*2/3 + width/24, height/2);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(64);
  text("Stage" + stage, width/2, height/2);

  fill(#69DEFF);
  //選択ボタン表示
  if (1 < stage) {
    triangle(width/4 - width*3/24, height/3, width/4 - width*3/24, height*2/3, width/24, height/2);
  }
  if (stage < max) {
    triangle(width*3/4 + width*3/24, height/3, width*3/4 + width*3/24, height*2/3, width*23/24, height/2);
  }

  noFill();
  //決定ボタン
  rect(width/3, height*13/16, width/3, height/8);
  textAlign(CENTER);
  textSize(32);
  text("Enter", width/2, height*14/16);
}

void line_dis() {
  int wide=100;
  stroke(0);
  line(wide, 0, wide, height);
  fill(255, 0, 0, 128);
  rect(0, height-180, 100, 180);
  stroke(255, 0, 0);
  line(0, height-90, wide, height-90);
  stroke(0);
}

void load() {
  ply_img = loadImage("642.png");
  ene_img = loadImage("640.png");
  r1 = loadImage("643.png");
  r2 = loadImage("644.png");
  r3 = loadImage("645.png");
  r4 = loadImage("646.png");
  g1 = loadImage("643g.png");
  g2 = loadImage("644g.png");
  g3 = loadImage("645g.png");
  g4 = loadImage("646g.png");
  b1 = loadImage("643b.png");
  b2 = loadImage("644b.png");
  b3 = loadImage("645b.png");
  b4 = loadImage("646b.png");
  ex_r = loadImage("ex_r.png");
  ex_g = loadImage("ex_g.png");
  ex_b = loadImage("ex_b.png");
  bg = loadImage("image1.png");
  chose_bg = loadImage("choosestage.png");
  logo = loadImage("logo.png");
  tit = loadImage("651.png");
  for (int i = 0; i < imgs.length; i++) {
    imgs[i] = loadImage("howto" + i + ".png");
  }
}

void setup() {
  player = new Player();
  enemy = new Enemy();
  load();
  mn=new Minim(this);
  audio=mn.loadFile("tobogeki.wav", 2048);
  audio.setGain(-10);
  size(1000, 800);
  frameRate(60);
  int s=200;
  for (int i=0; i<notes.length; i++) {
    notes_y[i]=(0-i*s);
    notes_hit[i]=false;
  }
  enemy_yb = int(random(0,3));
  
  noSmooth();
}

void draw() {
  if (scene == 0) {
    title();
  } else if (scene == 3) {
    play_cnt ++;
    image(bg, 0, 0);
    line_dis();
    audio.play();
    if (player.hp > 0) {
      player.display();
    }else{
      audio.close();
      audio=mn.loadFile("tobogeki.wav", 2048);
      audio.setGain(-10);
      int s=200;
      for (int i=0; i<notes.length; i++) {
        notes_y[i]=(0-i*s);
        notes_hit[i]=false;
      }
      play_cnt = 0;
      damage = 0;
      scene = 6;
    }
    if (enemy.hp > 0) {
      enemy.display();
    }
    p_img_y += move;
    e_img_y += move;
    if (frameCount % 60 == 30) {
      move *= -1;
    }
    if(play_cnt % 240 == 0){
      enemy_yb = int(random(0,3));
    }
    if (m_judge) {
      if (judge_y >= 710-20 && judge_y <= 710+20) {
        damage += 5;
        perfect = true;
      } else if (judge_y >= 710-40 && judge_y <= 710+30) {
        damage += 3;
        great = true;
      } else {
        damage += 1;
        good = true;
      }
      m_judge = false;
    }
    if (perfect) {
      t_cnt ++;
      fill(255, 255, 160);
      textSize(20);
      text("perfect!", 111, 710);
      textSize(30);
      if (t_cnt == 20) {
        t_cnt = 0;
        perfect = false;
      }
    }
    if (great) {
      t_cnt ++;
      fill(255, 223, 135);
      textSize(20);
      text("great!", 111, 710);
      textSize(30);
      if (t_cnt == 20) {
        t_cnt = 0;
        great = false;
      }
    }
    if (good) {
      t_cnt ++;
      fill(254, 198, 255);
      textSize(20);
      text("good!", 111, 710);
      textSize(30);
      if (t_cnt == 20) {
        t_cnt = 0;
        good = false;
      }
    }
    if (damage_e) {
      d_cnt ++;
      fill(255,0,0);
      text(damage_dis,850,200);
      if (color_num == 1) {
        if (d_cnt <= 5) {
          image(r1, 450, 220);
        } else if (d_cnt <= 10) {
          image(r2, 450, 220);
        } else if (d_cnt <= 15) {
          image(r3, 450, 220);
        } else if (d_cnt <= 20) {
          image(r4, 450, 220);
        }
      } else if (color_num == 2) {
        if (d_cnt <= 5) {
          image(g1, 450, 220);
        } else if (d_cnt <= 10) {
          image(g2, 450, 220);
        } else if (d_cnt <= 15) {
          image(g3, 450, 220);
        } else if (d_cnt <= 20) {
          image(g4, 450, 220);
        }
      } else if (color_num == 3) {
        if (d_cnt <= 5) {
          image(b1, 450, 220);
        } else if (d_cnt <= 10) {
          image(b2, 450, 220);
        } else if (d_cnt <= 15) {
          image(b3, 450, 220);
        } else if (d_cnt <= 20) {
          image(b4, 450, 220);
        }
      }
      if (d_cnt == 20) {
        d_cnt = 0;
        damage_e = false;
      }
    }
    if(enemy_yb == 0){
      image(ex_r,400,250);
    }else if(enemy_yb == 1){
      image(ex_g,400,250);
    }else if(enemy_yb == 2){
      image(ex_b,400,250);
    }
    if (damage_p) {
      d_cnt ++;
      fill(255,0,0);
      text("miss...",520,730);
      if (enemy_yb == 0) {
        if (d_cnt <= 5) {
          image(r1, 250, 450);
        } else if (d_cnt <= 10) {
          image(r2, 250, 450);
        } else if (d_cnt <= 15) {
          image(r3, 250, 450);
        } else if (d_cnt <= 20) {
          image(r4, 250, 450);
        }
      } else if (enemy_yb == 1) {
        if (d_cnt <= 5) {
          image(g1, 250, 450);
        } else if (d_cnt <= 10) {
          image(g2, 250, 450);
        } else if (d_cnt <= 15) {
          image(g3, 250, 450);
        } else if (d_cnt <= 20) {
          image(g4, 250, 450);
        }
      } else if (enemy_yb == 2) {
        if (d_cnt <= 5) {
          image(b1, 250, 450);
        } else if (d_cnt <= 10) {
          image(b2, 250, 450);
        } else if (d_cnt <= 15) {
          image(b3, 250, 450);
        } else if (d_cnt <= 20) {
          image(b4, 250, 450);
        }
      }
      if (d_cnt == 20) {
        d_cnt = 0;
        damage_p = false;
      }
    }
    for (int i=0; i<notes.length; i++) {
      noStroke();
      fill(0);
      notes_y[i]+=(bpm/10);
      if (notes[i]==1) {
        if (notes_hit[i]==false) {
          ellipse(50, notes_y[i], 90, 90);
        }
      }
    }
    text(command, 200, 700);
    if (play_cnt == 1350) {
      audio.close();
      audio=mn.loadFile("tobogeki.wav", 2048);
      audio.setGain(-10);
      int s=200;
      for (int i=0; i<notes.length; i++) {
        notes_y[i]=(0-i*s);
        notes_hit[i]=false;
      }
      play_cnt = 0;
      damage = 0;
      if (enemy.hp <= 0) {
        scene = 5; //勝利画面
      } else {
        scene = 6; //you lose
      }
    }
  } else if (scene == 1) {
    howto();
  } else if (scene == 2) {
    ChoseStages();
  } else if (scene == 5) {
    player.hp = 100;
    enemy.hp = 100;
    result("YOU WIN !", #DD1133);
  } else if (scene == 6) {
    player.hp = 100;
    enemy.hp = 100;
    result("YOU LOSE ...", #3749D7);
  }
}

void mousePressed() { 
  if (scene == 0) {
    if (mouseX>=width/2-150&&mouseX<=width/2+150&&mouseY>=height/2-50&&mouseY<=height/2+50&&mousePressed) {
      scene = 2;
    }
    if (mouseX>=width/2-150&&mouseX<=width/2+150&&mouseY>=height*3/4-50&&mouseY<=height*3/4+50&&mousePressed) {
      scene = 1;
    }
  }
  if (scene == 1) {
    if (height*8/10 <= mouseY && mouseY <= height*9/10) {
      if (width*0.8/10 <= mouseX && mouseX <= width*1.5/10 && slide > 0) slide--;
      if (width*8.5/10 <= mouseX && mouseX <= width*9.2/10 && slide < imgs.length -1 ) slide++;
    }
    if (width*2/3 <= mouseX && mouseX <= width*2/3 + width/4 && height/24 <= mouseY && mouseY <= height/6) {
      scene = 0;
    }
  }
  if (scene == 2) { //ステージ選択画面のみ有効
    //ステージ切り替え
    if (height/3 <= mouseY && mouseY <= height*2/3) {
      if (mouseX <= width/4 - width*3/24  && 1 < stage ) stage--;
      else if (width*3/4 + width*3/24 <= mouseX && stage < max) stage++;
    }
    //決定ボタン判定
    if (width/3 <= mouseX && mouseX <= width*2/3 && 
      height*13/16 <= mouseY && mouseY <= height*15/16) {
      scene = 3; //戦闘画面移行
    }
  }
}

void keyPressed() {
  for (int i=0; i<notes_hit.length; i++) {
    if (notes[i] == 1) {
      if (notes_y[i]>=height-180&&notes_y[i]<=height+45) {
        judge_y = int(notes_y[i]);
        if (notes_hit[i] == false) {
          m_judge = true;
        }
        cmd_input(i);
      }
    }
  }
}


void cmd_input(int i) {
  if (key == 'w') {
    command = command + "↑";
    cmd_cnt ++;
    notes_hit[i] = true;
  }
  if (key == 's') {
    command = command + "↓";
    cmd_cnt ++;
    notes_hit[i] = true;
  }
  if (key == 'd') {
    command = command + "→";
    cmd_cnt ++;
    notes_hit[i] = true;
  }
  if (key == 'a') {
    command = command + "←";
    cmd_cnt ++;
    notes_hit[i] = true;
  }
  if (key == ' ' || cmd_cnt == 6) {
    cmd_judge();
    command = "";
    cmd_cnt = 0;
    println();
  }
}

void cmd_judge() {
  if (command.equals(waza1)) {
    if(enemy_yb == 0){
      damage_dis = 20 + damage;
      enemy.hp -= damage_dis;
    }else{
      damage_dis = 5 + damage;
      enemy.hp -= damage_dis;
    }
    
    color_num = 1;
    damage = 0;
    damage_e = true;
  } else if (command.equals(waza2)) {
    if(enemy_yb == 1){
      damage_dis = 20 + damage;
      enemy.hp -= damage_dis;
    }else{
      damage_dis = 5 + damage;
      enemy.hp -= damage_dis;
    }
    color_num = 2;
    damage = 0;
    damage_e = true;
  } else if (command.equals(waza3)) {
    if(enemy_yb == 2){
      damage_dis = 20 + damage;
      enemy.hp -= damage_dis;
    }else{
      damage_dis = 5 + damage;
      enemy.hp -= damage_dis;
    }
    color_num = 3;
    damage = 0;
    damage_e = true;
  } else {
    text("miss...", 200, 700);
    player.hp -= 20;
    damage_p = true;
    damage = 0;
  }
}

void result(String msg, color col) {
  image(bg, 0, 0);
  if (isInside(width/8, height*2/3, width/4, height/8)) {
    fill(#E7FBC6);
    if (mousePressed) scene = 0;
  } else fill(255);
  rect(width/8, height*2/3, width/4, height/8);
  if (isInside(width*7/8 - width/4, height*2/3, width/4, height/8)) {
    fill(#E7FBC6);
    if (mousePressed) scene = 2;
  } else fill(255);
  rect(width*7/8 - width/4, height*2/3, width/4, height/8);

  textAlign(CENTER, CENTER);
  fill(col);
  textSize(128);
  text(msg, width/2, height/4);

  fill(0);
  textSize(32);
  text("home", width/8 + width/8, height*3/4);
  text("stage", width*3/4, height*3/4);
}

boolean isInside(int x, int y, int wid, int hei) {
  if (x < mouseX && mouseX < x + wid && y < mouseY && mouseY < y + hei) {
    return true;
  }
  return false;
}
