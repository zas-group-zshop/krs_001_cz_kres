<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductDetailPictures.ascx.cs" Inherits="ZASshop.NET.App_UserControls.ProductDetailPictures" %>

<%@ Register Assembly="ZAScontrols"        Namespace="ZAScontrols"        TagPrefix="zas" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Panel runat="server">
<!-- productImages -->
<div class="productImages product-detail-images">
	<div class="mainImage product-detail-main-image">
        <asp:HyperLink ID="hpMainPicture" runat="server" rel="picture_group">
            <asp:Image ID="imgMainPicture" runat="server" />
        </asp:HyperLink>
	</div>
				
	<div class="imageSlider product-detail-images">
		<div class="slider product-detail-slider">
            <asp:Repeater ID="rProductDetailPictures" runat="server"
                OnItemCommand="rProductDetailPictures_ItemCommand" >
                <ItemTemplate>
                    <a href='<%# DataBinder.Eval(Container.DataItem, "web_items_full_file") %>' rel="picture_group" class="disabled"
                        data-pk="<%# ZASutility.MyUtility.SafeEvalString(Container.DataItem,"pk") %>" data-pk-poradi="<%# ZASutility.MyUtility.SafeEvalInt(Container.DataItem,"poradi") %>"
                        <%# this.GetAttrAttData(ZASutility.MyUtility.SafeEvalString(Container.DataItem,"tabulka"), ZASutility.MyUtility.SafeEvalString(Container.DataItem,"pk"), ZASutility.MyUtility.SafeEvalInt(Container.DataItem,"poradi")) %>>
                        <asp:ImageButton ID="ImageButton1" runat="server"
						    AlternateText='<%# DataBinder.Eval(Container.DataItem, "description") %>'
						    CommandName="select" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "web_items_normal_file") %>'
						    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "web_items_preview_file") %>' />
                    </a>
                </ItemTemplate>
            </asp:Repeater>
		</div>
	</div>
</div>
<!-- /productImages -->
</asp:Panel>