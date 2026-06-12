<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>

<%
    String usuarioSesion =
            (String) session.getAttribute("usuario");

    String rol =
            (String) session.getAttribute("rol");

    if (usuarioSesion == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    if (!"VENDEDOR".equals(rol)) {
        response.sendRedirect("../index.html");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta http-equiv="Content-Type"
          content="text/html; charset=UTF-8">

    <title>Analítica de Ventas</title>

    <link href="../CSS/AnalisisVentas.css"
          rel="stylesheet"
          type="text/css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>

<%
    Connection con = Conexion.conectar();

    int totalVentas = 0;
    int totalClientes = 0;
    int totalResenas = 0;

    int ventasPagadas = 0;
    int ventasNoPagadas = 0;

    int ventasEntregadas = 0;
    int ventasPendientes = 0;

    double ingresosTotales = 0;
    double promedioCalificacion = 0;

    String productoMasVendido = "Sin datos";
    int ventasProducto = 0;
    
    StringBuilder productosLabels =
        new StringBuilder();

    StringBuilder productosVentas =
        new StringBuilder();
    
    StringBuilder estadosPagoLabels =
        new StringBuilder();

    StringBuilder estadosPagoValores =
        new StringBuilder();
    
    StringBuilder tipoPagoLabels =
        new StringBuilder();

    StringBuilder tipoPagoValores =
            new StringBuilder();

    String productoMasCaro = "Sin datos";
    double precioMasAlto = 0;

    // ==========================
    // TOTAL DE VENTAS
    // ==========================

    PreparedStatement st1 =
            con.prepareStatement(
                    "SELECT COUNT(*) total " +
                    "FROM Ventas"
            );

    ResultSet rs1 = st1.executeQuery();

    if(rs1.next()){

        totalVentas =
                rs1.getInt("total");
    }

    // ==========================
    // INGRESOS TOTALES
    // ==========================

    PreparedStatement st2 =
            con.prepareStatement(
                    "SELECT SUM(C.precio) ingresos " +
                    "FROM Ventas V " +
                    "INNER JOIN Catalogo C " +
                    "ON C.idProducto = V.Catalogo_idProducto"
            );

    ResultSet rs2 = st2.executeQuery();

    if(rs2.next()){

        ingresosTotales =
                rs2.getDouble("ingresos");
    }

    // ==========================
    // CLIENTES REGISTRADOS
    // ==========================

    PreparedStatement st3 =
            con.prepareStatement(
                    "SELECT COUNT(*) clientes " +
                    "FROM Cliente"
            );

    ResultSet rs3 = st3.executeQuery();

    if(rs3.next()){

        totalClientes =
                rs3.getInt("clientes");
    }

    // ==========================
    // TOTAL DE RESEÑAS
    // ==========================

    PreparedStatement st4 =
            con.prepareStatement(
                    "SELECT COUNT(*) resenas " +
                    "FROM Resenas"
            );

    ResultSet rs4 = st4.executeQuery();

    if(rs4.next()){

        totalResenas =
                rs4.getInt("resenas");
    }

    // ==========================
    // PROMEDIO DE CALIFICACIÓN
    // ==========================

    PreparedStatement st5 =
            con.prepareStatement(
                    "SELECT AVG(calificacion) promedio " +
                    "FROM Resenas"
            );

    ResultSet rs5 = st5.executeQuery();

    if(rs5.next()){

        promedioCalificacion =
                rs5.getDouble("promedio");
    }

    // ==========================
    // PRODUCTO MÁS VENDIDO
    // ==========================

    PreparedStatement st6 =
            con.prepareStatement(
                    "SELECT C.producto, COUNT(*) total " +
                    "FROM Ventas V " +
                    "INNER JOIN Catalogo C " +
                    "ON C.idProducto = V.Catalogo_idProducto " +
                    "GROUP BY C.producto " +
                    "ORDER BY total DESC " +
                    "LIMIT 1"
            );

    ResultSet rs6 = st6.executeQuery();

    if(rs6.next()){

        productoMasVendido =
                rs6.getString("producto");

        ventasProducto =
                rs6.getInt("total");
    }
    
    PreparedStatement stProductos =
            con.prepareStatement(
                "SELECT producto, COUNT(*) AS total " +
                "FROM Ventas " +
                "INNER JOIN Catalogo " +
                "ON Catalogo.idProducto = Ventas.Catalogo_idProducto " +
                "GROUP BY producto " +
                "ORDER BY total DESC " +
                "LIMIT 5"
            );

    ResultSet rsProductos =
            stProductos.executeQuery();

    while(rsProductos.next()){

        productosLabels.append("'")
                       .append(
                           rsProductos.getString(
                               "producto"
                           )
                       )
                       .append("',");

        productosVentas.append(
                rsProductos.getInt("total")
        ).append(",");
    }
    
    PreparedStatement stPago =
            con.prepareStatement(
                "SELECT estadoPago, COUNT(*) AS total " +
                "FROM Ventas " +
                "GROUP BY estadoPago"
            );

    ResultSet rsPago =
            stPago.executeQuery();

    while(rsPago.next()){

        estadosPagoLabels.append("'")
                         .append(
                             rsPago.getString(
                                 "estadoPago"
                             )
                         )
                         .append("',");

        estadosPagoValores.append(
                rsPago.getInt("total")
        ).append(",");
    }
    
    PreparedStatement stTipoPago =
            con.prepareStatement(
                "SELECT tipoPago, COUNT(*) AS total " +
                "FROM Ventas " +
                "GROUP BY tipoPago"
            );

    ResultSet rsTipoPago =
            stTipoPago.executeQuery();

    while(rsTipoPago.next()){

        tipoPagoLabels.append("'")
                      .append(
                          rsTipoPago.getString(
                              "tipoPago"
                          )
                      )
                      .append("',");

        tipoPagoValores.append(
                rsTipoPago.getInt("total")
        ).append(",");
    }
    
    // ==========================
    // PRODUCTO MÁS CARO
    // ==========================

    PreparedStatement st7 =
            con.prepareStatement(
                    "SELECT producto, precio " +
                    "FROM Catalogo " +
                    "ORDER BY precio DESC " +
                    "LIMIT 1"
            );

    ResultSet rs7 = st7.executeQuery();

    if(rs7.next()){

        productoMasCaro =
                rs7.getString("producto");

        precioMasAlto =
                rs7.getDouble("precio");
    }

    // ==========================
    // VENTAS PAGADAS
    // ==========================

    PreparedStatement st8 =
            con.prepareStatement(
                    "SELECT COUNT(*) total " +
                    "FROM Ventas " +
                    "WHERE estadoPago='Pagado'"
            );

    ResultSet rs8 = st8.executeQuery();

    if(rs8.next()){

        ventasPagadas =
                rs8.getInt("total");
    }

    // ==========================
    // VENTAS NO PAGADAS
    // ==========================

    PreparedStatement st9 =
            con.prepareStatement(
                    "SELECT COUNT(*) total " +
                    "FROM Ventas " +
                    "WHERE estadoPago='No pagado'"
            );

    ResultSet rs9 = st9.executeQuery();

    if(rs9.next()){

        ventasNoPagadas =
                rs9.getInt("total");
    }

    // ==========================
    // VENTAS ENTREGADAS
    // ==========================

    PreparedStatement st10 =
            con.prepareStatement(
                    "SELECT COUNT(*) total " +
                    "FROM Ventas " +
                    "WHERE estadoEntrega='Entregado'"
            );

    ResultSet rs10 = st10.executeQuery();

    if(rs10.next()){

        ventasEntregadas =
                rs10.getInt("total");
    }

    // ==========================
    // VENTAS PENDIENTES
    // ==========================

    PreparedStatement st11 =
            con.prepareStatement(
                    "SELECT COUNT(*) total " +
                    "FROM Ventas " +
                    "WHERE estadoEntrega<>'Entregado'"
            );

    ResultSet rs11 = st11.executeQuery();

    if(rs11.next()){

        ventasPendientes =
                rs11.getInt("total");
    }
%>

<header>

    <nav>

        <img src="../Imagenes/Flor.png"
             alt="Flor"
             width="50"
             height="50"/>

        <h2>Analítica de Ventas</h2>

        <a href="../logout">

            <img src="../Imagenes/Salida.png"
                 alt="Salir"
                 width="50"
                 height="50"/>

        </a>

    </nav>

</header>

<main>

    <section class="dashboard">

        <div class="card">

            <h3>Total de Ventas</h3>

            <p><%= totalVentas %></p>

        </div>

        <div class="card">

            <h3>Ingresos Totales</h3>

            <p>$<%= String.format("%.2f", ingresosTotales) %></p>

        </div>

        <div class="card">

            <h3>Clientes Registrados</h3>

            <p><%= totalClientes %></p>

        </div>

        <div class="card">

            <h3>Total de Reseñas</h3>

            <p><%= totalResenas %></p>

        </div>

        <div class="card">

            <h3>Ventas Pagadas</h3>

            <p><%= ventasPagadas %></p>

        </div>

        <div class="card">

            <h3>Ventas No Pagadas</h3>

            <p><%= ventasNoPagadas %></p>

        </div>

        <div class="card">

            <h3>Entregadas</h3>

            <p><%= ventasEntregadas %></p>

        </div>

        <div class="card">

            <h3>Pendientes de Entrega</h3>

            <p><%= ventasPendientes %></p>

        </div>

        <div class="card wide">

            <h3>Producto Más Vendido</h3>

            <p><%= productoMasVendido %></p>

            <span>
                <%= ventasProducto %> ventas
            </span>

        </div>

        <div class="card wide">

            <h3>Producto Más Caro</h3>

            <p><%= productoMasCaro %></p>

            <span>
                $<%= String.format("%.2f", precioMasAlto) %>
            </span>

        </div>

        <div class="card wide">

            <h3>Promedio de Calificaciones</h3>

            <p>

                ⭐ <%= String.format("%.1f", promedioCalificacion) %>

            </p>

        </div>

    </section>           
                
    <section class="charts-section">

        <div class="chart-card">

            <h3>Estado de Pagos</h3>

            <canvas id="graficaPagos"></canvas>

        </div>

        <div class="chart-card">

            <h3>Estado de Entregas</h3>

            <canvas id="graficaEntregas"></canvas>

        </div>
        
        <div class="chart-card">

            <h3>
                Productos Más Vendidos
            </h3>

            <canvas id="productosChart">
            </canvas>

        </div>

        <div class="chart-card">

            <h3>
                Ventas por Estado de Pago
            </h3>

            <canvas id="estadoPagoChart">
            </canvas>

        </div>

        <div class="chart-card">

            <h3>
                Ventas por Tipo de Pago
            </h3>

            <canvas id="tipoPagoChart">
            </canvas>

        </div>

    </section>

</main>

<a href="PerfilVendedor.jsp"
   class="btn-regresar">

    ⬅ Volver al Perfil

</a>

<footer>

    &COPY; Flower Garden - Gestión de plantas y jardinería

</footer>

<script>

const productosCtx =
        document.getElementById(
            'productosChart'
        );

new Chart(productosCtx, {

    type: 'bar',

    data: {

        labels: [
            <%= productosLabels.toString() %>
        ],

        datasets: [{

            label:
                'Ventas',

            data: [
                <%= productosVentas.toString() %>
            ],

            backgroundColor:
                'rgba(76,200,111,0.7)',

            borderColor:
                'rgba(47,138,71,1)',

            borderWidth: 2

        }]
    },

    options: {

        responsive: true,

        plugins: {

            legend: {

                display: false
            }
        },

        scales: {

            y: {

                beginAtZero: true
            }
        }
    }
});

const estadoPagoCtx =
        document.getElementById(
            'estadoPagoChart'
        );

new Chart(estadoPagoCtx, {

    type: 'bar',

    data: {

        labels: [
            <%= estadosPagoLabels.toString() %>
        ],

        datasets: [{

            label:
                'Ventas',

            data: [
                <%= estadosPagoValores.toString() %>
            ],

            backgroundColor: [

                '#4cc86f',
                '#f39c12',
                '#3498db',
                '#9b59b6'
            ]
        }]
    },

    options: {

        responsive: true,

        plugins: {

            legend: {

                display: false
            }
        },

        scales: {

            y: {

                beginAtZero: true
            }
        }
    }
});

const tipoPagoCtx =
        document.getElementById(
            'tipoPagoChart'
        );

new Chart(tipoPagoCtx, {

    type: 'bar',

    data: {

        labels: [
            <%= tipoPagoLabels.toString() %>
        ],

        datasets: [{

            label:
                'Ventas',

            data: [
                <%= tipoPagoValores.toString() %>
            ],

            backgroundColor: [

                '#2ecc71',
                '#3498db',
                '#9b59b6',
                '#e67e22'
            ]
        }]
    },

    options: {

        responsive: true,

        plugins: {

            legend: {

                display: false
            }
        },

        scales: {

            y: {

                beginAtZero: true
            }
        }
    }
});


// ==========================
// GRAFICA DE PAGOS
// ==========================

new Chart(
    document.getElementById("graficaPagos"),
    {
        type: "doughnut",

        data: {

            labels: [
                "Pagadas",
                "No Pagadas"
            ],

            datasets: [{

                data: [
                    <%= ventasPagadas %>,
                    <%= ventasNoPagadas %>
                ],

                backgroundColor: [
                    "#4cc86f",
                    "#ff6b6b"
                ]
            }]
        },

        options: {

            responsive: true,

            plugins: {

                legend: {

                    position: "bottom"
                }
            }
        }
    }
);

// ==========================
// GRAFICA DE ENTREGAS
// ==========================

new Chart(
    document.getElementById("graficaEntregas"),
    {
        type: "pie",

        data: {

            labels: [
                "Entregadas",
                "Pendientes"
            ],

            datasets: [{

                data: [
                    <%= ventasEntregadas %>,
                    <%= ventasPendientes %>
                ],

                backgroundColor: [
                    "#3ead57",
                    "#f7c948"
                ]
            }]
        },

        options: {

            responsive: true,

            plugins: {

                legend: {

                    position: "bottom"
                }
            }
        }
    }
);

</script>                
                
</body>
</html>