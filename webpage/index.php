 (192.168.1.203)' can't be established.
ECDSA key fingerprint is bf:f4:ce:71:18:d4:b1:c6:57:2a:18:f0:39:99:99:02.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'kassid,192.168.1.203' (ECDSA) to the list of known hosts.
pi@kassid's password: 
scp: /var/www/html/pics/hot.png: Permission denied
pi@kassid's password: 
scp: /var/www/html/pics/cold.png: Permission denied
pi@dussimeter ~/webcam $ cd
pi@dussimeter ~ $ sudo python imgcapture.py
python: can't open file 'imgcapture.py': [Errno 2] No such file or directory
pi@dussimeter ~ $ sudo nano webcam/imgcapture.py
pi@dussimeter ~ $ sudo python webcam/imgcapture.py
--- Opening /dev/video0...
Trying source module v4l2...
/dev/video0 opened.
No input was specified, using the first.
--- Capturing frame...
Corrupt JPEG data: 1 extraneous bytes before marker 0xd7
Captured frame in 0.00 seconds.
--- Processing captured image...
Writing JPEG image to '/home/pi/webcam/main.png'.
Traceback (most recent call last):
  File "webcam/imgcapture.py", line 42, in <module>
    hot = shpup.crop((100,330,370,430))
NameError: name 'shpup' is not defined
pi@dussimeter ~ $ sudo nano webcam/imgcapture.py
pi@dussimeter ~ $ sudo python webcam/imgcapture.py
--- Opening /dev/video0...
Trying source module v4l2...
/dev/video0 opened.
No input was specified, using the first.
--- Capturing frame...
Corrupt JPEG data: 1 extraneous bytes before marker 0xd7
Captured frame in 0.00 seconds.
--- Processing captured image...
Writing JPEG image to '/home/pi/webcam/main.png'.
pi@dussimeter ~ $ exit
logout
Connection to 192.168.1.116 closed.
Barrets-MBP:~ barretobrock$ ssh pi@192.168.1.203
pi@192.168.1.203's password: 

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Sun Oct 25 10:58:19 2015 from dussimeter.lan
pi@kassid ~ $ exit
logout
Connection to 192.168.1.203 closed.
Barrets-MBP:~ barretobrock$ ssh pi@192.168.1.203
pi@192.168.1.203's password: 

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Sun Oct 25 11:25:41 2015 from barrets-mbp.lan
pi@kassid ~ $ sudo nano /var/www/html/index.php

  GNU nano 2.2.6                                          File: /var/www/html/index.php                                                                                          

<html>
 <head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width">
   <title>rasPi Station</title>
   <link rel="stylesheet" href="http://kassid.local/styles.css"></link>
   <link rel="icon" type="image/png" href="http://kassid.local/water.png"></link>
  </head>
  <body id="main">
    <ul><li><a href="http://kassid.local">Home</a></li>
       <li><a href="">About</a></li>
       <li>
         Graphs
         <ul>
           <li><a href="graphs.php">Temp & Humidity</a></li>
         </ul>
       </li>
       <li>
         Directories
         <ul>
           <li><a href="http://kassid.local/homecopy/" target="_blank">Elutuba</a></li>
           <li><a href="http://dussimeter.local/homecopy/" target="_blank">Dušširuum</a></li>
         </ul>
       </li>
       <li>
         Actions
         <ul>
           <li><a href="http://kassid.local/meterRead.php">Meter Reading</a></li>
           <li><a href="http://kassid.local/test.php" target="_blank">Test</a></li>
         </ul>
       </li>
       <li><a href="">Contact</a></li>
     </ul>
     <h1>Raspberry Pi Homepage</h1>
      <div class="elucard">
          <div class="rect-wrapper">
              <div class="cur-wrapper">
                  <div class="location">
                      <a href="#">Elutuba</a>
                  </div>
                  <div class="pws"></div>
                  <div class="curtemp" style="color:#52b673">
                    <?php
                    $thefile = file_get_contents('tempnow/elutemp.txt');
                    echo $thefile;
                    ?>
                  </div>
                  <div class="curhum" style="color:#52b673">
                    <?php
                    $thefile = file_get_contents('tempnow/eluhum.txt');
                    echo $thefile;
                    ?>
                  </div>
              </div>
          </div>
      </div>
      <div class="magacard">
          <div class="rect-wrapper">
            <div class="cur-wrapper">
                  <div class="location">
                      <a href="#">Magamistuba</a>
                  </div>
                  <div class="pws"></div>
                  <div class="curtemp" style="color:#52b673">
                    <?php
                    $thefile = file_get_contents('tempnow/magatemp.txt');
                    echo $thefile;
                    ?>
                  </div>
                  <div class="curhum" style="color:#52b673">
                    <?php
                    $thefile = file_get_contents('tempnow/magahum.txt');
                    echo $thefile;
                    ?>
                  </div>
              </div>
          </div>
      </div>
    <footer id="footer">
      <p>
        <?php echo "Today is: " . date('Y-m-d H:i:s'); ?>
      </p>
    </footer>
  </body>
</html>
