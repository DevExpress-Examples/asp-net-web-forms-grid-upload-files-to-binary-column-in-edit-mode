Imports System
Imports System.Data
Imports System.Data.SqlClient

Partial Public Class _Default
    Inherits System.Web.UI.Page

    Private Const SessionKey As String = "UploadedFileContent"
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As EventArgs)
        If (Not IsCallback) AndAlso (Not IsPostBack) Then
            Session.Clear()
        End If
    End Sub
    Protected Sub ASPxUploadControl1_FileUploadComplete(ByVal sender As Object, ByVal e As DevExpress.Web.FileUploadCompleteEventArgs)
        If e.IsValid Then
            Session(SessionKey) = e.UploadedFile.FileBytes
            e.CallbackData = e.UploadedFile.FileName
        End If
    End Sub
    Protected Sub ASPxGridView1_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)
        If Session(SessionKey) IsNot Nothing Then
            e.NewValues("Picture") = Session(SessionKey)
        End If
        DeleteUploadedFileFormSession()
        Throw New CustomExceptions.MyException("Data updates aren't allowed in online examples")
    End Sub
    Protected Sub ASPxCallback1_Callback(ByVal source As Object, ByVal e As DevExpress.Web.CallbackEventArgs)
        DeleteUploadedFileFormSession()
        e.Result = "ok"
    End Sub
    Protected Sub SqlDataSource1_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs)
        Dim sqlVarBinaryParameter As SqlParameter = CType(e.Command.Parameters(0), SqlParameter)
        sqlVarBinaryParameter.SqlDbType = SqlDbType.VarBinary
    End Sub
    Private Sub DeleteUploadedFileFormSession()
        Session.Remove(SessionKey)
    End Sub
    Protected Sub ASPxGridView1_CustomErrorText(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewCustomErrorTextEventArgs)
        If TypeOf e.Exception Is CustomExceptions.MyException Then
            e.ErrorText = e.Exception.Message
        End If
    End Sub
End Class