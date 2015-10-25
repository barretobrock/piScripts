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
      <div class="hotcard">
          <div class="rect-wrapper">
              <div class="cur-wrapper">
                <div class="h2olocation">
                   <a href="#">Elutuba</a>
               </div>
               <div class="pws"></div>
               <div class="hotpic">
                 <img src="http://dussimeter.local/homecopy/webcam/hot.png" alt="" />
               </div>
           </div>
       </div>
   </div>
   <div class="coldcard">
          <div class="rect-wrapper">
              <div class="cur-wrapper">
                  <div class="h2olocation">
                      <a href="#">Cold Water</a>
                  </div>
                  <div class="pws"></div>
                  <div class="coldpic">
                    <img src="http://dussimeter.local/homecopy/webcam/cold.png" alt="" />
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
