Imports System.Drawing
Imports System.Drawing.Printing
Imports System.Collections

Namespace AARS.Framework.Reportes

    Public Class clsComprobanteRetencion

        Private headerLines As New ArrayList()
        Private subHeaderLines As New ArrayList()
        Private items As New ArrayList()
        Private subitemsLine As New ArrayList()
        Private totales As New ArrayList()
        Private footerLines As New ArrayList()
        Private m_headerImage As Image = Nothing

        Private m_leftMargin As Single
        Private m_topMargin As Single
        Private m_topMargin2 As Single
        Private m_count As Integer
        Private m_count2 As Decimal
        Private m_count3 As Decimal
        Private m_cont As Double

        Private m_maxChar As Integer = 100
        Private m_maxCharDescription As Integer = 70

        Private imageHeight As Integer = 0
        Private m_fontName As String = "Courier New"
        Private m_fontSize As Integer = 9

        Private printFont As Font = Nothing
        Private myBrush As New SolidBrush(Color.Black)

        Private gfx As Graphics = Nothing

        Private line As String = Nothing

        Private iteLin As [String](,) = New [String](999, 5) {}

        Public Sub New()
        End Sub

#Region "Variables - Estructura"
        Public Property leftMargin() As Single
            Get
                Return m_leftMargin
            End Get
            Set(ByVal value As Single)
                If m_leftMargin <> value Then
                    m_leftMargin = value
                End If
            End Set
        End Property

        Public Property topMargin() As Single
            Get
                Return m_topMargin
            End Get
            Set(ByVal value As Single)
                If m_topMargin <> value Then
                    m_topMargin = value
                End If
            End Set
        End Property

        Public Property topMargin2() As Single
            Get
                Return m_topMargin2
            End Get
            Set(ByVal value As Single)
                If m_topMargin2 <> value Then
                    m_topMargin2 = value
                End If
            End Set
        End Property

        Public Property count() As Single
            Get
                Return m_count
            End Get
            Set(ByVal value As Single)
                If m_count <> value Then
                    m_count = value
                End If
            End Set
        End Property

        Public Property count2() As Single
            Get
                Return m_count2
            End Get
            Set(ByVal value As Single)
                If m_count2 <> value Then
                    m_count2 = value
                End If
            End Set
        End Property

        Public Property count3() As Single
            Get
                Return m_count3
            End Get
            Set(ByVal value As Single)
                If m_count3 <> value Then
                    m_count3 = value
                End If
            End Set
        End Property

        Public Property cont() As Single
            Get
                Return m_cont
            End Get
            Set(ByVal value As Single)
                If m_cont <> value Then
                    m_cont = value
                End If
            End Set
        End Property
#End Region

        Public Property HeaderImage() As Image
            Get
                Return m_headerImage
            End Get
            Set(ByVal value As Image)
                If m_headerImage IsNot value Then
                    m_headerImage = value
                End If
            End Set
        End Property

        Public Property MaxChar() As Integer
            Get
                Return m_maxChar
            End Get
            Set(ByVal value As Integer)
                If value <> m_maxChar Then
                    m_maxChar = value
                End If
            End Set
        End Property

        Public Property MaxCharDescription() As Integer
            Get
                Return m_maxCharDescription
            End Get
            Set(ByVal value As Integer)
                If value <> m_maxCharDescription Then
                    m_maxCharDescription = value
                End If
            End Set
        End Property

        Public Property FontSize() As Integer
            Get
                Return m_fontSize
            End Get
            Set(ByVal value As Integer)
                If value <> m_fontSize Then
                    m_fontSize = value
                End If
            End Set
        End Property

        Public Property FontName() As String
            Get
                Return m_fontName
            End Get
            Set(ByVal value As String)
                If value <> m_fontName Then
                    m_fontName = value
                End If
            End Set
        End Property

        Public Sub AddHeaderLine(ByVal line As String)
            headerLines.Add(line)
        End Sub

        Public Sub AddSubHeaderLine(ByVal line1 As String, ByVal line2 As String)
            Dim newLineaSH As New OrderLineSH("?"c)
            subHeaderLines.Add(newLineaSH.GenerateLineSH(line1, line2))
        End Sub

        Public Sub AddItem(ByVal FechaVenta As String, ByVal item As String, ByVal price As String)
            Dim newItem As New OrderItem2("?"c)
            items.Add(newItem.GenerateItem(FechaVenta, item, price))
        End Sub

        Public Sub AddSubItem(ByVal IVA_Retenido As String)
            subitemsLine.Add(IVA_Retenido)
        End Sub

        Public Sub AddTotal(ByVal price As String)
            Dim newTotal As New OrderTotal2("?"c)
            totales.Add(newTotal.GenerateTotal(price))
        End Sub

        Public Sub AddFooterLine(ByVal line As String)
            footerLines.Add(line)
        End Sub

        Private Function AlignRightText(ByVal lenght As Integer) As String
            Dim espacios As String = ""
            Dim spaces As Integer = m_maxChar - lenght
            For x As Integer = 0 To spaces - 1
                espacios += " "
            Next
            Return espacios
        End Function

        Private Function AlignRightText2(ByVal lenght As Integer) As String
            Dim espacios As String = ""
            Dim m_maxChar2 As Integer = 75
            Dim spaces As Integer = m_maxChar2 - lenght
            For x As Integer = 0 To spaces - 1
                espacios += " "
            Next
            Return espacios
        End Function

        Private Function DottedLine() As String
            Dim dotted As String = ""
            For x As Integer = 0 To m_maxChar - 1
                dotted += ""
            Next
            Return dotted
        End Function


        Public Function PrinterExists(ByVal impresora As String) As Boolean
            For Each strPrinter As [String] In PrinterSettings.InstalledPrinters
                If impresora = strPrinter Then
                    Return True
                End If
            Next
            Return False
        End Function

        Public Sub PrintComprobante(ByVal impresora As String)
            printFont = New Font(m_fontName, m_fontSize, FontStyle.Regular)
            Dim pr As New PrintDocument()
            pr.PrinterSettings.PrinterName = impresora
            AddHandler pr.PrintPage, New PrintPageEventHandler(AddressOf pr_PrintPage)
            pr.Print()
        End Sub

        Private Sub pr_PrintPage(ByVal sender As Object, ByVal e As System.Drawing.Printing.PrintPageEventArgs)
            e.Graphics.PageUnit = GraphicsUnit.Millimeter
            gfx = e.Graphics

            DrawImage()
            DrawHeader()
            DrawSubHeader()
            DrawItems()
            DrawSubItems()
            DrawTotales()
            DrawFooter()

            If m_headerImage IsNot Nothing Then
                HeaderImage.Dispose()
                m_headerImage.Dispose()
            End If
        End Sub

        Private Function YPosition0() As Single
            'Dim height As Single = myFont.GetHeight(e.Graphics)
            Dim valor As Single = topMargin2 + (count * printFont.GetHeight(gfx) + imageHeight)
            valor = valor
            Return topMargin2 + (count * printFont.GetHeight(gfx) + imageHeight)
        End Function

        Private Function YPosition() As Single
            'Dim height As Single = myFont.GetHeight(e.Graphics)
            Dim valor As Single = topMargin + (count * printFont.GetHeight(gfx) + imageHeight)
            valor = valor
            Return topMargin + (count * printFont.GetHeight(gfx) + imageHeight)
        End Function

        Private Function YPositionTiva() As Single
            'Dim height As Single = myFont.GetHeight(e.Graphics)
            Dim valor As Single = 28 + (count2 * printFont.GetHeight(gfx) + imageHeight)
            valor = valor
            Return 35 + (count2 * printFont.GetHeight(gfx) + imageHeight)
        End Function

        Private Function YPosition2() As Single
            'Dim height As Single = myFont.GetHeight(e.Graphics)
            Dim valor As Single = topMargin + (count2 * printFont.GetHeight(gfx))
            valor = valor
            Return topMargin + (count2 * printFont.GetHeight(gfx))
        End Function

        Private Sub DrawImage()
            If m_headerImage IsNot Nothing Then
                Try
                    gfx.DrawImage(m_headerImage, New Point(CInt(Math.Truncate(leftMargin)), CInt(Math.Truncate(YPosition()))))
                    Dim height As Double = (CDbl(m_headerImage.Height) / 58) * 15
                    imageHeight = CInt(Math.Truncate(Math.Round(height))) + 3
                Catch generatedExceptionName As Exception
                End Try
            End If
        End Sub

        Private Sub DrawHeader()
            For Each header As String In headerLines
                If header.Length > m_maxChar Then
                    Dim currentChar As Integer = 0
                    Dim headerLenght As Integer = header.Length

                    While headerLenght > m_maxChar
                        line = header.Substring(currentChar, m_maxChar)
                        gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition(), New StringFormat())

                        count += 1
                        currentChar += m_maxChar
                        headerLenght -= m_maxChar
                    End While
                    line = header
                    gfx.DrawString(line.Substring(currentChar, line.Length - currentChar), printFont, myBrush, leftMargin, YPosition(), New StringFormat())
                    count += 1
                Else
                    line = header
                    gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition(), New StringFormat())

                    count += 1
                End If
            Next
            DrawEspacio()
        End Sub

        Private Sub DrawSubHeader()
            Dim ordLin As New OrderLineSH("?"c)
            Dim contLines As Integer = 1
            Dim i As Integer = 0

            For Each subHeader As String In subHeaderLines

                If contLines = 1 Then

                    line = ordLin.GetItemLinea1(subHeader)
                    leftMargin = 35
                    gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition0(), New StringFormat())

                    leftMargin = 33
                    line = EspacioEnBlanco(20) & ordLin.GetItemLinea2(subHeader)
                    line = AlignRightText2(line.Length) & line

                    gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition0(), New StringFormat())
                    count2 += 2.25
                    count += 2

                ElseIf contLines <> 6 Then

                    line = ordLin.GetItemLinea1(subHeader)
                    leftMargin = 35
                    gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition2(), New StringFormat())

                    leftMargin = 0
                    line = EspacioEnBlanco(25) & ordLin.GetItemLinea2(subHeader)

                    If line.Trim <> "" Then

                        line = AlignRightText2(line.Length) & line

                        gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition2(), New StringFormat())

                    End If

                    count += 2
                    count2 += 1.6

                Else

                    leftMargin = 14
                    line = EspacioEnBlanco(50) & ordLin.GetItemLinea1(subHeader)

                    gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition2(), New StringFormat())

                    leftMargin = 0
                    line = EspacioEnBlanco(10) & ordLin.GetItemLinea2(subHeader)

                    If line.Trim <> "" Then

                        line = AlignRightText2(line.Length) & line

                        gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition2(), New StringFormat())

                    End If

                End If

                contLines += 1
                i += 1
            Next

            DrawEspacio()

        End Sub

        Private Sub DrawItems()
            Dim ordIt As New OrderItem2("?"c)

            DrawEspacio()

            For Each item As String In items
                line = ordIt.GetItemFecha(item)

                leftMargin = 10
                gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition(), New StringFormat())

                line = ordIt.GetItemPrice(item)
                line = AlignRightText(line.Length) & line

                leftMargin = 0
                gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition(), New StringFormat())

                Dim name As String = ordIt.GetItemName(item)

                leftMargin = 10
                If name.Length > m_maxCharDescription Then
                    Dim currentChar As Integer = 0
                    Dim itemLenght As Integer = name.Length

                    While itemLenght > m_maxCharDescription
                        line = ordIt.GetItemName(item)
                        gfx.DrawString(EspacioEnBlanco(12) & line.Substring(currentChar, m_maxCharDescription), printFont, myBrush, leftMargin, YPosition(), New StringFormat())

                        count += 1
                        currentChar += m_maxCharDescription
                        itemLenght -= m_maxCharDescription
                    End While

                    line = ordIt.GetItemName(item)
                    gfx.DrawString(EspacioEnBlanco(12) & line.Substring(currentChar, line.Length - currentChar), printFont, myBrush, leftMargin, YPosition(), New StringFormat())
                    count += 1
                Else
                    gfx.DrawString(EspacioEnBlanco(12) & ordIt.GetItemName(item), printFont, myBrush, leftMargin, YPosition(), New StringFormat())

                    count += 1
                End If
            Next

            leftMargin = 0
            DrawEspacio()

            line = DottedLine()

            gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition(), New StringFormat())

            count += 1

            DrawEspacio()
            DrawEspacio()
            DrawEspacio()
            DrawEspacio()
            DrawEspacio()
            'quitar una linea de espacio
            'DrawEspacio()
            'DrawEspacio()
        End Sub

        Private Sub DrawSubItems()
            Dim NumLetras As String
            For Each subitems As String In subitemsLine

                line = subitems
                leftMargin = 20
                count2 += 14.5

                NumLetras = IVA_RetenidoLetras(CDec(line.Trim)).Trim + " DOLARES"
                gfx.DrawString(NumLetras, printFont, myBrush, leftMargin, YPosition2(), New StringFormat())

                count += 1

            Next
            leftMargin = 0
            DrawEspacio()
        End Sub

        Private Sub DrawTotales()
            Dim ordTot As New OrderTotal2("?"c)
            Dim contLines As Integer = 1
            'leftMargin = 40
            'line = EspacioEnBlanco(20) & ordLin.GetItemLinea2(subHeader)
            'line = AlignRightText2(line.Length) & line

            'gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition0(), New StringFormat())

            For Each total As String In totales

                line = ordTot.GetTotalCantidad(total)
                line = AlignRightText(line.Length) & line

                If contLines = 1 Then
                    count2 += 2
                Else
                    count2 += 1.7
                End If

                gfx.DrawString(line, printFont, myBrush, leftMargin, YPositionTiva(), New StringFormat())
                leftMargin = 0

                line = EspacioEnBlanco(30) & ordTot.GetTotalName(total)
                gfx.DrawString(line, printFont, myBrush, leftMargin, YPositionTiva(), New StringFormat())
                DrawEspacio()

                contLines = contLines + 1

            Next
            leftMargin = 0
            DrawEspacio()
            DrawEspacio()
        End Sub

        Private Sub DrawFooter()
            For Each footer As String In footerLines
                If footer.Length > m_maxChar Then
                    Dim currentChar As Integer = 0
                    Dim footerLenght As Integer = footer.Length

                    While footerLenght > m_maxChar
                        line = footer
                        gfx.DrawString(line.Substring(currentChar, m_maxChar), printFont, myBrush, leftMargin, YPosition(), New StringFormat())

                        count += 1
                        currentChar += m_maxChar
                        footerLenght -= m_maxChar
                    End While
                    line = footer
                    gfx.DrawString(line.Substring(currentChar, line.Length - currentChar), printFont, myBrush, leftMargin, YPosition(), New StringFormat())
                    count += 1
                Else
                    line = footer
                    gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition(), New StringFormat())

                    count += 1
                End If
            Next
            leftMargin = 0
            DrawEspacio()
        End Sub

        Private Sub DrawEspacio()
            line = ""

            gfx.DrawString(line, printFont, myBrush, leftMargin, YPosition(), New StringFormat())

            count += 1
        End Sub

        Private Function EspacioEnBlanco(ByVal NumeroEspacios As Integer) As String
            Dim objstring As String = ""

            objstring = Microsoft.VisualBasic.Space(NumeroEspacios)
            Return objstring
        End Function

        Public Function IVA_RetenidoLetras(ByVal IVA_Retenido As Decimal) As String

            Dim TCIF(12) As String
            Dim TUNI(30) As String
            Dim TCEN(10) As String
            Dim TDECE(10) As String
            Dim LETVAL As String
            Dim SRX As String = ""

            Dim i As Integer


            LETVAL = "NUMERO DEMASIADO GRANDE"

            If IVA_Retenido > 29999999.99 Then
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

            XSUELDA = LTrim$(RTrim$(IVA_Retenido.ToString("########.#0")))

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

    Public Class OrderLineSH
        Private delimitador As Char() = New Char() {"?"c}

        Public Sub New(ByVal delimit As Char)
            delimitador = New Char() {delimit}
        End Sub

        Public Function GetItemLinea1(ByVal lineItem As String) As String
            Dim delimitado As String() = lineItem.Split(delimitador)
            Return delimitado(0)
        End Function

        Public Function GetItemLinea2(ByVal lineItem As String) As String
            Dim delimitado As String() = lineItem.Split(delimitador)
            Return delimitado(1)
        End Function

        Public Function GenerateLineSH(ByVal itemLinea1 As String, ByVal itemLinea2 As String) As String
            Return itemLinea1 & delimitador(0) & itemLinea2
        End Function

    End Class

    Public Class OrderItem2
        Private delimitador As Char() = New Char() {"?"c}

        Public Sub New(ByVal delimit As Char)
            delimitador = New Char() {delimit}
        End Sub

        Public Function GetItemFecha(ByVal orderItem As String) As String
            Dim delimitado As String() = orderItem.Split(delimitador)
            Return delimitado(0)
        End Function

        Public Function GetItemName(ByVal orderItem As String) As String
            Dim delimitado As String() = orderItem.Split(delimitador)
            Return delimitado(1)
        End Function

        Public Function GetItemPrice(ByVal orderItem As String) As String
            Dim delimitado As String() = orderItem.Split(delimitador)
            Return delimitado(2)
        End Function

        Public Function GenerateItem(ByVal FechaVenta As String, ByVal itemName As String, ByVal price As String) As String
            Return FechaVenta & delimitador(0) & itemName & delimitador(0) & price
        End Function
    End Class

    Public Class OrderTotal2
        Private delimitador As Char() = New Char() {"?"c}

        Public Sub New(ByVal delimit As Char)
            delimitador = New Char() {delimit}
        End Sub

        Public Function GetTotalName(ByVal totalItem As String) As String
            Dim delimitado As String() = totalItem.Split(delimitador)
            Return delimitado(0)
        End Function

        Public Function GetTotalCantidad(ByVal totalItem As String) As String
            Dim delimitado As String() = totalItem.Split(delimitador)
            Return delimitado(1)
        End Function

        Public Function GenerateTotal(ByVal price As String) As String
            Return delimitador(0) & price
        End Function
    End Class

End Namespace
