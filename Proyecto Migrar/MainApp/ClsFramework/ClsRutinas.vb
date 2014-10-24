Namespace SIS.Framework.Common
    Public Class ClsRutinas

        Public Function NALMA(ByVal SUELDO As Decimal) As String


            Dim TCIF(12) As String
            Dim TUNI(30) As String
            Dim TCEN(10) As String
            Dim TDECE(10) As String
            Dim LETVAL As String
            Dim SRX As String = ""

            Dim i As Integer


            LETVAL = "NUMERO DEMASIADO GRANDE"

            If SUELDO > 29999999.99 Then
                GoTo FINA
            End If


            i = 1
            While i <= 11
                TCIF(i) = Space(10)
                i = i + 1
            End While

            TUNI(1) = "UN"
            TUNI(2) = "DOS"
            TUNI(3) = "TRES"
            TUNI(4) = "CUATRO"
            TUNI(5) = "CINCO"
            TUNI(6) = "SEIS"
            TUNI(7) = "SIETE"
            TUNI(8) = "OCHO"
            TUNI(9) = "NUEVE"
            TUNI(10) = "DIEZ"
            TUNI(11) = "ONCE"
            TUNI(12) = "DOCE"
            TUNI(13) = "TRECE"
            TUNI(14) = "CATORCE"
            TUNI(15) = "QUINCE"
            TUNI(16) = "DIECISEIS"
            TUNI(17) = "DIECISIETE"
            TUNI(18) = "DIECIOCHO"
            TUNI(19) = "DIECINUEVE"
            TUNI(20) = "VEINTE"
            TUNI(21) = "VEINTIUNO"
            TUNI(22) = "VEINTIDOS"
            TUNI(23) = "VEINTITRES"
            TUNI(24) = "VEINTICUATRO"
            TUNI(25) = "VEINTICINCO"
            TUNI(26) = "VEINTISEIS"
            TUNI(27) = "VEINTISIETE"
            TUNI(28) = "VEINTIOCHO"
            TUNI(29) = "VEINTINUEVE"

            TCEN(1) = "CIENTO"
            TCEN(2) = "DOSCIENTOS"
            TCEN(3) = "TRESCIENTOS"
            TCEN(4) = "CUATROCIENTOS"
            TCEN(5) = "QUINIENTOS"
            TCEN(6) = "SEISCIENTOS"
            TCEN(7) = "SETECIENTOS"
            TCEN(8) = "OCHOCIENTOS"
            TCEN(9) = "NOVECIENTOS"

            TDECE(1) = Space(10)
            TDECE(2) = Space(10)
            TDECE(3) = "TREINTA"
            TDECE(4) = "CUARENTA"
            TDECE(5) = "CINCUENTA"
            TDECE(6) = "SESENTA"
            TDECE(7) = "SETENTA"
            TDECE(8) = "OCHENTA"
            TDECE(9) = "NOVENTA"


            Dim IND As Integer
            Dim SENA As Integer

            Dim XSUELDA As String
            Dim xlargo As Integer
            Dim SUELDOAL As String

            Dim I1 As String
            Dim I2 As String
            Dim XIND As String

            SRX = ""

            IND = 0

            SENA = 0

            'XSUELDA = LTrim$(RTrim$(Format(SUELDO, "########.#0")))

            XSUELDA = LTrim$(RTrim$(SUELDO.ToString("########.#0")))

            xlargo = Len(XSUELDA)

            XSUELDA = Space(11 - xlargo) + XSUELDA

            SUELDOAL = Left(XSUELDA, 8) + Right(XSUELDA, 2)
            SRX = SUELDOAL


            ' BUSCA MILLONES


            TUNI(1) = "UN"
            TUNI(21) = "VENTIUN"

            If Val(Left(SRX, 1)) > 0 Or Val(Mid(SRX, 2, 1)) > 0 Then
                I1 = Left(SRX, 1)
                I2 = Mid(SRX, 2, 1)
                XIND = I1 + I2
                IND = Val(XIND)
                TCIF(1) = RTrim$(LTrim$(TUNI(IND)))
                TCIF(2) = "MILLONES"
                If IND = 1 Then
                    TCIF(2) = "MILLON"
                End If
            End If


            ' MUEVE CENTENAS MILES

            If Val(Mid(SRX, 3, 1)) > 0 Then
                TCIF(7) = "MIL"
                If Val(Mid(SRX, 3, 1)) = 1 And (Val(Mid(SRX, 4, 1)) = 0 And Val(Mid(SRX, 5, 1)) = 0) Then
                    TCIF(3) = "CIEN"
                Else
                    TCIF(3) = TCEN(Val(Mid(SRX, 3, 1)))
                End If
            End If

            TUNI(1) = "UN"
            TUNI(21) = "VENTIUN"



            ' MUEVE DECENAS MILES




            If Val(Mid(SRX, 4, 1)) > 0 Or Val(Mid(SRX, 5, 1)) > 0 Then
                TCIF(7) = "MIL"
                If Val(Mid(SRX, 4, 1)) < 3 Then
                    I1 = Mid(SRX, 4, 1)
                    I2 = Mid(SRX, 5, 1)
                    XIND = I1 + I2
                    IND = Val(XIND)
                    TCIF(4) = LTrim$(RTrim$(TUNI(IND)))
                Else
                    TCIF(4) = TDECE(Val(Mid(SRX, 4, 1)))
                    If Val(Mid(SRX, 5, 1)) > 0 Then
                        TCIF(5) = "Y"
                        TCIF(6) = TUNI(Val(Mid(SRX, 5, 1)))
                    End If
                End If
            End If

            TUNI(1) = "UN"
            TUNI(21) = "VENTIUN"


            ' MUEVE CENTENAS


            If Val(Mid(SRX, 6, 1)) > 0 Then
                If Val(Mid(SRX, 6, 1)) = 1 And (Val(Mid(SRX, 7, 1)) = 0 And Val(Mid(SRX, 8, 1)) = 0) Then
                    TCIF(8) = "CIEN"
                Else
                    TCIF(8) = TCEN(Val(Mid(SRX, 6, 1)))
                End If
            End If

            TUNI(1) = "UN"
            TUNI(21) = "VENTIUNO"

            ' MUEVE DECENAS

            If Val(Mid(SRX, 7, 1)) > 0 Or Val(Mid(SRX, 8, 1)) > 0 Then
                If Val(Mid(SRX, 7, 1)) < 3 Then
                    I1 = Mid(SRX, 7, 1)
                    I2 = Mid(SRX, 8, 1)
                    XIND = I1 + I2
                    IND = Val(XIND)
                    TCIF(9) = LTrim$(RTrim$(TUNI(IND)))
                Else
                    TCIF(9) = TDECE(Val(Mid(SRX, 7, 1)))
                    If Val(Mid(SRX, 8, 1)) > 0 Then
                        TCIF(10) = "Y"
                        TCIF(11) = TUNI(Val(Mid(SRX, 8, 1)))
                    End If
                End If
            End If


            i = 1

            LETVAL = ""
            While i <= 11
                If Len(LTrim$(RTrim$(TCIF(i)))) <> 0 Then
                    LETVAL = LETVAL + LTrim$(RTrim$(TCIF(i))) + " "
                End If
                i = i + 1
            End While

FINA:

            LETVAL = LETVAL + Right(SRX, 2) + "/100"


            Return LETVAL

        End Function
    End Class
End Namespace
