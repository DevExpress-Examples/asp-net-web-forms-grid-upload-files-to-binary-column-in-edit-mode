<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v15.1, Version=15.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function OnFileUploadComplete(s, e) {
            if (e.callbackData !== "") {
                lblFileName.SetText(e.callbackData);
                btnDeleteFile.SetVisible(true);
            }
        }
        function OnClick(s, e) {
            callback.PerformCallback(lblFileName.GetText());
        }
        function OnCallbackComplete(s, e) {
            if (e.result === "ok") {
                lblFileName.SetText(null);
                btnDeleteFile.SetVisible(false);
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="ID" OnRowUpdating="ASPxGridView1_RowUpdating"
            OnCustomErrorText="ASPxGridView1_CustomErrorText">
            <Columns>
                <dx:GridViewCommandColumn ShowEditButton="true" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Visible="false" VisibleIndex="2">
                    <EditFormSettings Visible="True" />
                    <EditItemTemplate>
                        <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" AutoStartUpload="true" UploadMode="Auto" OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete">
                            <ClientSideEvents FileUploadComplete="OnFileUploadComplete" />
                        </dx:ASPxUploadControl>
                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" ClientInstanceName="lblFileName"></dx:ASPxLabel>
                        <dx:ASPxButton ID="ASPxButton1" RenderMode="Link" runat="server" ClientVisible="false" ClientInstanceName="btnDeleteFile" AutoPostBack="false" Text="Remove">
                            <ClientSideEvents Click="OnClick" />
                        </dx:ASPxButton>
                    </EditItemTemplate>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsEditing EditFormColumnCount="1"></SettingsEditing>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BinaryImagesDBConnectionString %>"
            SelectCommand="SELECT [ID], [Picture] FROM [BinaryImagesTable]"
            UpdateCommand="UPDATE [BinaryImagesTable] SET [Picture] = @Picture WHERE [ID] = @ID" OnUpdating="SqlDataSource1_Updating">
            <UpdateParameters>
                <asp:Parameter Name="Picture" Type="Object" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="callback" OnCallback="ASPxCallback1_Callback">
            <ClientSideEvents CallbackComplete="OnCallbackComplete" />
        </dx:ASPxCallback>
    </form>
</body>
</html>