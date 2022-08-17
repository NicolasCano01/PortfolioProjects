Attribute VB_Name = "Module1"
'Pasos Macro
'1. Limpiar hoja de salida
'2. Obtener las distintas combinaciones de cuentas y descripci—n.
'    2.1 Eliminar combinaciones que no corresponden (Balance, Unidad de negocio, contratos de gol, mes inicial, mes final)
'3. Recorrer listado de combinaciones e ir buscando match en columnas AB. Al encontrar match,
'    3.1 Almacenar posici—n del match
'    3.2 Seleccionar celda y hacer Alt+tab hacia arriba para encontrar encabezado, almacenar posici—n encabezado
'    3.3 Valores a buscar  columna:G, K, O, S, W, AA, AE, fila de 3.1
'        3.4 Si hay valor, registrar combinaciones de 2.1, cuenta Ñ>en respectiva columna y fila 3.2 -1, y valor encontrado



Sub Macro1()
Attribute Macro1.VB_ProcData.VB_Invoke_Func = " \n14"
'
' 1 Limpiar tablas de salida
Sheets(3).Range("A2:B" & Rows.Count).ClearContents
Sheets(4).Range("A2:D" & Rows.Count).ClearContents

' 2 Obtener las distintas combinaciones de cuentas y descripci—n
Sheets(2).Range("A:B").Copy Sheets(3).Range("A:B")
Sheets(3).Range("A:B").RemoveDuplicates Columns:=Array(1, 2), Header:=xlNo

End Sub

Sub Macro2()
'3. Recorrer listado de combinaciones e ir buscando match en columnas AB. Al encontrar match,
last2 = Sheets(2).Cells(Rows.Count, "A").End(xlUp).Row
last3 = Sheets(3).Cells(Rows.Count, "A").End(xlUp).Row
last4 = Sheets(4).Cells(Rows.Count, "A").End(xlUp).Row

For Each cell In Sheets(2).Range("A1:A" & last2)
'Se podria hacer sin necesidad del paso 2. Sin encontrar las diferentes combinaciones
    If UCase(cell.Value) Like "*0*" Or UCase(cell.Value) Like "*1*" Or UCase(cell.Value) Like "*2*" _
    Or UCase(cell.Value) Like "*3" Then
        roweval = cell.Row  '    3.1 Almacenar posici—n del match
        Title = cell.End(xlUp).Row '    3.2 Encontrar encabezado, almacenar posici—n encabezado
        
        'MsgBox "roweval =" & roweval
        'MsgBox "last4 =" & last4
        
        last4 = Sheets(4).Cells(Rows.Count, "A").End(xlUp).Row
        ValorG = Replace(Sheets(2).Range("G" & roweval), " ", "")
        '3.3Revisar proyectos si tienen resultados
        'If (UCase(Range("G" & roweval)) Like "*0*") Or (UCase(Range("G" & roweval)) Like "*1*") Or (UCase(Range("G" & roweval)) Like "*2*") _
        '    Or (UCase(Range("G" & roweval)) Like "*3") Then
        If (UCase(ValorG) Like "*0*") Or (UCase(ValorG) Like "*1*") Or (UCase(ValorG) Like "*2*") _
            Or (UCase(ValorG) Like "*3") Then
            Sheets(4).Range("A" & last4 + 1) = Sheets(2).Range("A" & roweval)
            Sheets(4).Range("B" & last4 + 1) = Sheets(2).Range("B" & roweval)
            Sheets(4).Range("C" & last4 + 1) = Sheets(2).Range("D" & Title - 1)
            Sheets(4).Range("D" & last4 + 1) = Sheets(2).Range("G" & roweval)
        End If
        
        last4 = Sheets(4).Cells(Rows.Count, "A").End(xlUp).Row
        ValorK = Replace(Sheets(2).Range("K" & roweval), " ", "")
        If (UCase(ValorK) Like "*0*") Or (UCase(ValorK) Like "*1*") Or (UCase(ValorK) Like "*2*") _
            Or (UCase(ValorK) Like "*3") Then
            Sheets(4).Range("A" & last4 + 1) = Sheets(2).Range("A" & roweval)
            Sheets(4).Range("B" & last4 + 1) = Sheets(2).Range("B" & roweval)
            Sheets(4).Range("C" & last4 + 1) = Sheets(2).Range("H" & Title - 1)
            Sheets(4).Range("D" & last4 + 1) = Sheets(2).Range("K" & roweval)
        End If
        
        last4 = Sheets(4).Cells(Rows.Count, "A").End(xlUp).Row
        ValorO = Replace(Sheets(2).Range("O" & roweval), " ", "")
        If (UCase(ValorO) Like "*0*") Or (UCase(ValorO) Like "*1*") Or (UCase(ValorO) Like "*2*") _
            Or (UCase(ValorO) Like "*3") Then
            Sheets(4).Range("A" & last4 + 1) = Sheets(2).Range("A" & roweval)
            Sheets(4).Range("B" & last4 + 1) = Sheets(2).Range("B" & roweval)
            Sheets(4).Range("C" & last4 + 1) = Sheets(2).Range("L" & Title - 1)
            Sheets(4).Range("D" & last4 + 1) = Sheets(2).Range("O" & roweval)
        End If
        
        last4 = Sheets(4).Cells(Rows.Count, "A").End(xlUp).Row
        ValorS = Replace(Sheets(2).Range("S" & roweval), " ", "")
        If (UCase(ValorS) Like "*0*") Or (UCase(ValorS) Like "*1*") Or (UCase(ValorS) Like "*2*") _
            Or (UCase(ValorS) Like "*3") Then
            Sheets(4).Range("A" & last4 + 1) = Sheets(2).Range("A" & roweval)
            Sheets(4).Range("B" & last4 + 1) = Sheets(2).Range("B" & roweval)
            Sheets(4).Range("C" & last4 + 1) = Sheets(2).Range("P" & Title - 1)
            Sheets(4).Range("D" & last4 + 1) = Sheets(2).Range("S" & roweval)
        End If
        
        last4 = Sheets(4).Cells(Rows.Count, "A").End(xlUp).Row
        ValorW = Replace(Sheets(2).Range("W" & roweval), " ", "")
        If (UCase(ValorW) Like "*0*") Or (UCase(ValorW) Like "*1*") Or (UCase(ValorW) Like "*2*") _
            Or (UCase(ValorW) Like "*3") Then
            Sheets(4).Range("A" & last4 + 1) = Sheets(2).Range("A" & roweval)
            Sheets(4).Range("B" & last4 + 1) = Sheets(2).Range("B" & roweval)
            Sheets(4).Range("C" & last4 + 1) = Sheets(2).Range("T" & Title - 1)
            Sheets(4).Range("D" & last4 + 1) = Sheets(2).Range("W" & roweval)
        End If
        
        last4 = Sheets(4).Cells(Rows.Count, "A").End(xlUp).Row
        ValorAA = Replace(Sheets(2).Range("AA" & roweval), " ", "")
        If (UCase(ValorAA) Like "*0*") Or (UCase(ValorAA) Like "*1*") Or (UCase(ValorAA) Like "*2*") _
            Or (UCase(ValorAA) Like "*3") Then
            Sheets(4).Range("A" & last4 + 1) = Sheets(2).Range("A" & roweval)
            Sheets(4).Range("B" & last4 + 1) = Sheets(2).Range("B" & roweval)
            Sheets(4).Range("C" & last4 + 1) = Sheets(2).Range("X" & Title - 1)
            Sheets(4).Range("D" & last4 + 1) = Sheets(2).Range("AA" & roweval)
        End If
        
        last4 = Sheets(4).Cells(Rows.Count, "A").End(xlUp).Row
        ValorAA = Replace(Sheets(2).Range("O" & roweval), " ", "")
        If (UCase(ValorAE) Like "*0*") Or (UCase(ValorAE) Like "*1*") Or (UCase(ValorAE) Like "*2*") _
            Or (UCase(ValorAE) Like "*3") Then
            Sheets(4).Range("A" & last4 + 1) = Sheets(2).Range("A" & roweval)
            Sheets(4).Range("B" & last4 + 1) = Sheets(2).Range("B" & roweval)
            Sheets(4).Range("C" & last4 + 1) = Sheets(2).Range("AB" & Title - 1)
            Sheets(4).Range("D" & last4 + 1) = Sheets(2).Range("AE" & roweval)
        End If
        
        
        'MsgBox "roweval =" & roweval
        'MsgBox "Title =" & Title
    End If
    
Next cell

End Sub




