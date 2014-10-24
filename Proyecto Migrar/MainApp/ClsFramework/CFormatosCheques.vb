Imports System.IO
Imports System.Text
Imports ClsFramework.AARS.Framework.Common
Imports System.Configuration

Namespace AARS.Framework.Reportes
    Public Class CFormatosCheques
        Public Function FAgricola01(ByVal strFecha As String, ByVal ValorCheque As Decimal, ByVal Beneficiario As String) As String
            Dim ObjString As New StringBuilder()

            Dim StrLineaFecha As String = ""

            Dim intNumeroLineasFinales As Integer = System.Configuration.ConfigurationManager.AppSettings.Get("NumeroLineasFinalesChq01")

            Try
                ' Encabezado en blanco
                For nlineas As Integer = 1 To 4
                    ObjString.AppendLine(LineaEnBlanco())
                Next

                ' Fecha y monto

                StrLineaFecha = "San Salvador, " + Right(strFecha, 2) + " de " + NombreMes(Int32.Parse(Mid(strFecha, 5, 2)))

                If StrLineaFecha.Length >= 25 Then
                    StrLineaFecha = EspacioEnBlanco(12 - (StrLineaFecha.Length - 25)) + StrLineaFecha
                Else
                    StrLineaFecha = EspacioEnBlanco(12) + StrLineaFecha
                End If

                StrLineaFecha = StrLineaFecha.ToUpper()

                StrLineaFecha = StrLineaFecha + EspacioEnBlanco(40 - StrLineaFecha.Length)
                StrLineaFecha = StrLineaFecha + Left(strFecha, 4)
                StrLineaFecha = StrLineaFecha + EspacioEnBlanco(6)

                Dim strMonto As String = ValorCheque.ToString("n2")

                strMonto = strMonto.Trim()

                If strMonto.Length < 13 Then
                    strMonto = strMonto + ReplicateString("*", 13 - strMonto.Length)
                End If

                StrLineaFecha = StrLineaFecha + strMonto

                ObjString.AppendLine(StrLineaFecha)

                ObjString.AppendLine(LineaEnBlanco())

                ' Beneficiario

                Beneficiario = Beneficiario.Trim()

                If Beneficiario.Length < 53 Then
                    Beneficiario = Beneficiario + ReplicateString("*", 53 - Beneficiario.Length)
                End If

                Beneficiario = EspacioEnBlanco(12) + Beneficiario

                ObjString.AppendLine(Beneficiario)

                ObjString.AppendLine(LineaEnBlanco())

                ' Valor en Letras

                Dim objRutinas As New ClsRutinas

                Dim ValorenLetras As String = objRutinas.NALMA(ValorCheque)
                Dim ValorenLetras1 As String = ""
                Dim ValorenLetras2 As String = ""

                ValorenLetras = ValorenLetras.Trim()

                Dim LargoValorLetras = ValorenLetras.Length
                Dim LargoValor1 As Integer = 0

                If LargoValorLetras < 53 Then
                    ValorenLetras1 = EspacioEnBlanco(12) + ValorenLetras + ReplicateString("*", 53 - LargoValorLetras)
                Else
                    'ValorenLetras1 = EspacioEnBlanco(12) + ValorenLetras.Substring(0, 52)

                    LargoValor1 = ValorenLetras.Substring(0, 52).LastIndexOf(" ")

                    ValorenLetras1 = EspacioEnBlanco(12) + ValorenLetras.Substring(0, LargoValor1)

                End If

                If LargoValorLetras < 53 Then
                    ValorenLetras2 = EspacioEnBlanco(3) + ReplicateString("*", 20)
                Else
                    ValorenLetras2 = EspacioEnBlanco(3) + ValorenLetras.Substring(LargoValor1).Trim + ReplicateString("*", 20 - ValorenLetras.Substring(LargoValor1).Trim.Length)
                End If

                ObjString.AppendLine(ValorenLetras1)
                ObjString.AppendLine(LineaEnBlanco())

                ObjString.AppendLine(ValorenLetras2)
                ObjString.AppendLine(LineaEnBlanco())


                For nlineas As Integer = 1 To intNumeroLineasFinales
                    ObjString.AppendLine(LineaEnBlanco())
                Next



            Catch ex As Exception

                Throw New Exception(ex.Message)

            End Try

            Return ObjString.ToString

        End Function

        Private Function LineaEnBlanco() As String
            Dim objstring As String = ""

            objstring = EspacioEnBlanco(80)
            Return objstring
        End Function

        Private Function EspacioEnBlanco(ByVal NumeroEspacios As Integer) As String
            Dim objstring As String = ""

            objstring = Microsoft.VisualBasic.Space(NumeroEspacios)
            Return objstring
        End Function


        Private Function NombreMes(ByVal NumeroMes As Integer) As String
            Dim strMes As String = ""
            Select Case NumeroMes
                Case 1
                    strMes = "Enero"
                Case 2
                    strMes = "Febrero"
                Case 3
                    strMes = "Marzo"
                Case 4
                    strMes = "Abril"
                Case 5
                    strMes = "Mayo"
                Case 6
                    strMes = "Junio"
                Case 7
                    strMes = "Julio"
                Case 8
                    strMes = "Agosto"
                Case 9
                    strMes = "Septiembre"
                Case 10
                    strMes = "Octubre"
                Case 11
                    strMes = "Noviembre"
                Case 12
                    strMes = "Diciembre"
            End Select
            Return strMes
        End Function

        Private Function ReplicateString(ByVal Source As String, ByVal Times As Integer) As String
            Dim i As Integer
            Dim sb As New Text.StringBuilder(Source.Length * Times)
            For i = 1 To Times
                sb.Append(Source)
            Next
            Return sb.ToString
        End Function

    End Class
End Namespace
