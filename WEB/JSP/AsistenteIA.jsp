<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

    <head>

        <meta http-equiv="Content-Type"
              content="text/html; charset=UTF-8">

        <title>Asistente IA</title>

        <link href="../CSS/AsistenteIA.css"
              rel="stylesheet"
              type="text/css"/>

    </head>

    <body>

        <header>

            <nav>

                <img src="../Imagenes/Flor.png"
                     alt="Flower Garden"
                     width="50"
                     height="50"/>

                <h2>Asistente IA de Jardinería</h2>

                <a href="../index.html">

                    <img src="../Imagenes/Salida.png"
                         alt="Salir"
                         width="50"
                         height="50"/>

                </a>

            </nav>

        </header>

        <main>

            <section class="chat-container">

                <div class="chat-header">

                    <h1>🌱 Flower Garden AI</h1>

                    <p>
                        Pregunta sobre riego,
                        iluminación, fertilizantes,
                        plagas, flores y cuidados.
                    </p>

                </div>

                <div class="chat-box">

                    <%
                        String pregunta =
                            request.getParameter("pregunta");

                        String respuesta = "";

                        if(pregunta != null){

                            String p =
                                pregunta.toLowerCase();

                            if(
                                p.contains("hola") ||
                                p.contains("buenas") ||
                                p.contains("saludos")
                            ){

                                respuesta =
                                    "¡Hola! 🌿 Soy el asistente inteligente de Flower Garden. Puedes preguntarme sobre riego, cactus, flores, plagas, fertilizantes, luz solar y cuidados generales.";

                            }
                            
                            else if(
                                p.contains("regar") &&
                                p.contains("todos los dias")
                            ){

                                respuesta =
                                    "No todas las plantas deben regarse diariamente 🌱. El exceso de agua puede pudrir las raíces. Lo ideal es revisar si la tierra está seca antes de volver a regar.";

                            }

                            else if(
                                p.contains("regar") ||
                                p.contains("riego")
                            ){

                                respuesta =
                                    "El riego depende del tipo de planta, temperatura y humedad. La mayoría de plantas de interior deben regarse cuando la capa superior de la tierra esté seca.";

                            }

                            else if(
                                p.contains("cactus")
                            ){

                                respuesta =
                                    "Los cactus necesitan mucha luz solar ☀️ y poca agua. Riégalos únicamente cuando la tierra esté completamente seca para evitar que se pudran.";

                            }

                            else if(
                                p.contains("suculenta") ||
                                p.contains("suculentas")
                            ){

                                respuesta =
                                    "Las suculentas almacenan agua en sus hojas, por eso necesitan riegos moderados. También requieren buena iluminación y macetas con drenaje.";

                            }

                            else if(
                                p.contains("orquidea") ||
                                p.contains("orquídea")
                            ){

                                respuesta =
                                    "Las orquídeas necesitan luz indirecta, humedad moderada y riego ligero. Evita dejarlas bajo el sol directo porque sus hojas pueden quemarse.";

                            }

                            else if(
                                p.contains("rosa") ||
                                p.contains("rosas")
                            ){

                                respuesta =
                                    "Las rosas necesitan al menos 6 horas de sol al día 🌹 y riego frecuente. También es importante podarlas regularmente para estimular nuevas flores.";

                            }

                            else if(
                                p.contains("girasol") ||
                                p.contains("girasoles")
                            ){

                                respuesta =
                                    "Los girasoles aman el sol ☀️. Necesitan bastante luz directa y riego moderado para crecer fuertes y saludables.";

                            }

                            else if(
                                p.contains("marchita") ||
                                p.contains("marchito")
                            ){

                                respuesta =
                                    "Si tu planta está marchita puede deberse a exceso de agua, falta de riego, poca luz o plagas. Revisa el estado de la tierra y las hojas.";

                            }

                            else if(
                                p.contains("hojas amarillas") ||
                                p.contains("amarillas")
                            ){

                                respuesta =
                                    "Las hojas amarillas suelen indicar exceso de agua 💧 o falta de nutrientes. También pueden aparecer por mala iluminación.";

                            }

                            else if(
                                p.contains("hojas secas") ||
                                p.contains("secas")
                            ){

                                respuesta =
                                    "Las hojas secas normalmente indican falta de agua o humedad ambiental baja. También puede deberse a demasiado sol directo.";

                            }

                            else if(
                                p.contains("luz") ||
                                p.contains("sol")
                            ){

                                respuesta =
                                    "La mayoría de plantas necesitan buena iluminación 🌞, pero no todas toleran el sol directo. Las plantas de interior prefieren luz indirecta.";

                            }

                            else if(
                                p.contains("sombra")
                            ){

                                respuesta =
                                    "Las plantas de sombra deben mantenerse alejadas del sol intenso. Helechos y potus son ejemplos de plantas que crecen bien con poca luz.";

                            }

                            else if(
                                p.contains("plaga") ||
                                p.contains("insectos") ||
                                p.contains("mosquitos")
                            ){

                                respuesta =
                                    "Para combatir plagas puedes usar jabón potásico, aceite de neem o limpiar las hojas regularmente. Mantener la planta sana ayuda a prevenir insectos.";

                            }

                            else if(
                                p.contains("hongos")
                            ){

                                respuesta =
                                    "Los hongos aparecen por exceso de humedad 🍄. Reduce el riego y mejora la ventilación alrededor de la planta.";

                            }

                            else if(
                                p.contains("fertilizante") ||
                                p.contains("abono")
                            ){

                                respuesta =
                                    "Las plantas deben fertilizarse cada 15 o 30 días dependiendo de la especie. El exceso de fertilizante también puede dañarlas.";

                            }

                            else if(
                                p.contains("flores")
                            ){

                                respuesta =
                                    "Las plantas con flores necesitan buena iluminación, nutrientes y riego moderado 🌸 para florecer correctamente.";

                            }

                            else if(
                                p.contains("transplantar") ||
                                p.contains("maceta")
                            ){

                                respuesta =
                                    "Debes trasplantar una planta cuando las raíces ocupen toda la maceta. Usa tierra nueva y una maceta ligeramente más grande.";

                            }

                            else if(
                                p.contains("tierra") ||
                                p.contains("sustrato")
                            ){

                                respuesta =
                                    "Un buen sustrato debe permitir drenaje y ventilación. La mezcla ideal depende del tipo de planta.";

                            }

                            else if(
                                p.contains("interior")
                            ){

                                respuesta =
                                    "Las plantas de interior necesitan buena ventilación, luz indirecta y evitar cambios bruscos de temperatura.";

                            }

                            else if(
                                p.contains("exterior")
                            ){

                                respuesta =
                                    "Las plantas de exterior suelen necesitar más agua y soportan mejor el sol directo y el clima.";

                            }

                            else if(
                                p.contains("crecer") ||
                                p.contains("crecimiento")
                            ){

                                respuesta =
                                    "Para estimular el crecimiento de una planta necesitas buena luz, nutrientes, riego adecuado y una maceta con buen drenaje.";

                            }

                            else{

                                respuesta =
                                    "Lo siento 🌱, todavía estoy aprendiendo sobre ese tema. Puedes preguntarme sobre riego, cactus, flores, fertilizantes, plagas, iluminación y cuidados de plantas.";
                            }
                        }
                    %>

                    <%
                        if(pregunta != null){
                    %>

                    <div class="message user">

                        <div class="bubble">

                            <%= pregunta %>

                        </div>

                    </div>

                    <div class="message bot">

                        <div class="bubble">

                            <%= respuesta %>

                        </div>

                    </div>

                    <%
                        }else{
                    %>

                    <div class="message bot">

                        <div class="bubble">

                            ¡Hola! 🌿
                            Soy el asistente IA de Flower Garden.
                            ¿En qué puedo ayudarte hoy?

                        </div>

                    </div>

                    <%
                        }
                    %>

                </div>

                <form action="AsistenteIA.jsp"
                      method="post"
                      class="chat-form">
                    
                    <input type="hidden"
                        name="nombre"
                        value="<%=request.getParameter("nombre")%>">
                    
                    <input type="text"
                           name="pregunta"
                           placeholder="Escribe tu pregunta..."
                           required>

                    <button type="submit">

                        Enviar

                    </button>

                </form>

            </section>

        </main>
        <a href="PerfilCliente.jsp?nombre=<%=request.getParameter("nombre")%>" 
           accesskey=""class="btn-regresar">

            ⬅ Volver al Perfil

        </a>
        <footer>

            &COPY; Flower Garden - Gestión de plantas y jardinería

        </footer>

    </body>

</html>
