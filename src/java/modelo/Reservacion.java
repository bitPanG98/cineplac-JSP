/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author Poolvazo
 */
public class Reservacion {

    private String codigoReservacion;
    private String fechaReservacion;
    private double totalPagar;
    private String estadoReservacion;
    private String cod_reservacion;
    private String cod_cliente;
    private String cod_pelicula;
    private int cantidad;
    private double subtotal;

    public Reservacion() {

    }

    public String getCodigoReservacion() {
        return codigoReservacion;
    }

    public void setCodigoReservacion(String codigoReservacion) {
        this.codigoReservacion = codigoReservacion;
    }

    public String getFechaReservacion() {
        return fechaReservacion;
    }

    public void setFechaReservacion(String fechaReservacion) {
        this.fechaReservacion = fechaReservacion;
    }

    public double getTotalPagar() {
        return totalPagar;
    }

    public void setTotalPagar(double totalPagar) {
        this.totalPagar = totalPagar;
    }

    public String getEstadoReservacion() {
        return estadoReservacion;
    }

    public void setEstadoReservacion(String estadoReservacion) {
        this.estadoReservacion = estadoReservacion;
    }

    public String getCod_reservacion() {
        return cod_reservacion;
    }

    public void setCod_reservacion(String cod_reservacion) {
        this.cod_reservacion = cod_reservacion;
    }

    public String getCod_cliente() {
        return cod_cliente;
    }

    public void setCod_cliente(String cod_cliente) {
        this.cod_cliente = cod_cliente;
    }

    public String getCod_pelicula() {
        return cod_pelicula;
    }

    public void setCod_pelicula(String cod_pelicula) {
        this.cod_pelicula = cod_pelicula;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    
    

}
