<%-- 
    Document   : index
    Created on : 23-nov-2018, 20:46:08
    Author     : Poolvazo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta charset="utf-8">	
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> * Cine Plac * </title>
        			
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>

        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/animate.css">
        <link rel="stylesheet" href="css/main.css">

        <link rel="stylesheet" href="css/animate.css">
        <link rel="stylesheet" href="css/owl.carousel.css" >
        <link rel="stylesheet" href="css/owl.theme.css" >
        <link rel="stylesheet" href="css/owl.transitions.css" >
        <link rel="stylesheet" href="css/style.css" >
        <link rel="stylesheet" href="css/responsive.css" >
        <link rel="stylesheet" type="text/css" href="css/color/green.css">
		
	<style type="text/css">
            .footer {
                /* Altura total del footer en px con valor negativo */
                margin-top: -50px;
                /* Altura del footer en px. Se han restado los 5px del margen
                    superior mas los 5px del margen inferior
                */
            	height: 40px;
           	padding:10px 0px;
           	background: #000000;
		text-align: center;
		width:99%;
		margin:10px 10px;
		position:fixed;
		left:0px;
   		bottom:0px;
   		color: #88b77b;
            }
	</style>

        
    </head>
    <body id="body">
        
        <header id="navigation" class="navbar-fixed-top navbar">
            <div class="container">
                <nav class="collapse navbar-collapse navbar-right">
                    <ul class="nav navbar-nav">                
                        <li>
                            <a href="#"> Inicio </a>
                        </li>
                        
                        <li>
                            <a href="vistas/form_login.jsp" target="_blank"> Iniciar Sesion </a>
                        </li>
                        
                        <li>
                            <a href=""> Peliculas </a>
                        </li>
                        
                        <li>
                            <a href=""> Acerca de </a>
                        </li>
                    </ul>
                </nav>		
            </div>
        </header>
				
        <section id="slider">
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">

                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>			

                <div class="carousel-inner" role="listbox">

                    <div class="item active" style="background-image: url(imagenes/Banner/banner1.jpg);">
                        <div class="carousel-caption">
                            <h2 data-wow-duration="700ms" data-wow-delay="500ms" class="wow bounceInDown animated"><span> </span> </h2>
                            <h3 data-wow-duration="1000ms" class="wow slideInLeft animated">
                                <span class="color">Cine Plac !!</span>
                            </h3>
                            <p data-wow-duration="1000ms" class="wow slideInRight animated"> Las mejores peliculas no se ven, se viven :) ..!!!!!</p>
                        </div>
                    </div>

                    <div class="item" style="background-image: url(imagenes/Banner/banner2.jpg);">
                        <div class="carousel-caption">
                            <h2 data-wow-duration="500ms" data-wow-delay="500ms" class="wow bounceInDown animated"><span> </span></h2>
                            <h3 data-wow-duration="500ms" class="wow slideInLeft animated"><span class="color"> </span> </h3>
                            <p data-wow-duration="500ms" class="wow slideInRight animated"></p>
                        </div>
                    </div>

                    <div class="item" style="background-image: url(imagenes/Banner/banner3.jpg);">
                        <div class="carousel-caption">
                            <h2 data-wow-duration="500ms" data-wow-delay="500ms" class="wow bounceInDown animated"> <span> </span></h2>
                            <h3 data-wow-duration="500ms" class="wow slideInLeft animated"><span class="color">Vive,</span>la mejor experiencia viendo peliculas :) </h3>
                            <p data-wow-duration="500ms" class="wow slideInRight animated">
                            </p>
                        </div>
                    </div>

                </div>			
            </div>
        </section>
		

	<!-- Seccion de peliculas -->
        <section id="team" class="team-member-section">
        <div class="container"> 
            <div class="row">
                <div class="col-md-12">
                    <div id="team-section">   
                        
                        <div class="our-team">
                            <div class="team-member">
                                <img src="imagenes/original/pelicula1.jpg" class="img-responsive" alt="">
                                <div class="team-details">
                                    <h4>Viviendo Con ella </h4>
                                    <p></p>
                                </div>
                            </div>

                            <div class="team-member">
                                <img src="imagenes/original/pelicula2.jpg" class="img-responsive" alt="">
                                <div class="team-details">
                                    <h4>HackerMan</h4>
                                    <p></p>
                                </div>
                            </div>

                            <div class="team-member">
                                <img src="imagenes/original/pelicula3.jpg" class="img-responsive" alt="">
                                <div class="team-details">
                                    <h4>Naruto Shipudden</h4>
                                    <p></p>
                                </div>
                            </div>    

                            <div class="team-member">
                                <img src="imagenes/original/pelicula4.jpg" class="img-responsive" alt="">
                                <div class="team-details">
                                    <h4>Transformers</h4>
                                    <p></p>
                                </div>
                            </div>

                            <div class="team-member">
                                <img src="imagenes/original/pelicula5.jpg" class="img-responsive" alt="">
                                <div class="team-details">
                                    <h4>Dragon Ball Z </h4>
                                    <p></p>
                                </div>
                            </div>

                            <div class="team-member">
                                <img src="imagenes/original/pelicula6.jpg" class="img-responsive" alt="">
                                <div class="team-details">
                                    <h4>Rapidos y Furiosos I</h4>
                                    <p></p>
                                </div>
                            </div>
                            
                        </div>                    
                    </div>
                </div>
            </div>
                
        </div>
    </section>
    <table  style="margin: -425px 0"  width="100%">
        <tr>
            <td bgcolor="#610000">
                <img height="330px">
            </td>
        </tr>
     </table>
		

    <section>
        <div class="footer">
            <p>Copyritgh (c) *Cine Plac* </p>
        </div>
    </section>

    <script src="js/jquery-1.11.1.min.js"></script>	
    <script src="js/jquery.singlePageNav.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/count-to.js"></script>
    <script src="js/jquery.appear.js"></script>
    <script src="js/owl.carousel.min.js"></script> 
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>


    <script>
        var wow = new WOW ({
            boxClass:     'wow',      
            animateClass: 'animated', 
            offset:       120,          
            mobile:       false,       
            live:         true        
              }
            );
            wow.init();
    </script> 

    <script src="js/custom.js"></script>
    <script src="js/script.js"></script>
        
    </body>
</html>
