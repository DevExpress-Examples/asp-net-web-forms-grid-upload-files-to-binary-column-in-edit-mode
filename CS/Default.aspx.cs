using System;
using System.Data;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page {
    const string SessionKey = "UploadedFileContent";
    protected void Page_Init(object sender, EventArgs e) {
        if (!IsCallback && !IsPostBack)
            Session.Clear();
    }
    protected void ASPxUploadControl1_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e) {
        if (e.IsValid) {
            Session[SessionKey] = e.UploadedFile.FileBytes;
            e.CallbackData = e.UploadedFile.FileName;
        }
    }
    protected void ASPxGridView1_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e) {
        if (Session[SessionKey] != null)
            e.NewValues["Picture"] = Session[SessionKey];
        DeleteUploadedFileFormSession();
        throw new CustomExceptions.MyException("Data updates aren't allowed in online examples");
    }
    protected void ASPxCallback1_Callback(object source, DevExpress.Web.CallbackEventArgs e) {
        DeleteUploadedFileFormSession();
        e.Result = "ok";
    }
    protected void SqlDataSource1_Updating(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e) {
        SqlParameter sqlVarBinaryParameter = (SqlParameter)e.Command.Parameters[0];
        sqlVarBinaryParameter.SqlDbType = SqlDbType.VarBinary;
    }
    private void DeleteUploadedFileFormSession() {
        Session.Remove(SessionKey);
    }
    protected void ASPxGridView1_CustomErrorText(object sender, DevExpress.Web.ASPxGridViewCustomErrorTextEventArgs e) {
        if (e.Exception is CustomExceptions.MyException)
            e.ErrorText = e.Exception.Message;
    }
}