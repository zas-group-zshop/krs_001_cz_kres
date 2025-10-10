<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductListCustomFilters.ascx.cs" Inherits="ZASshop.NET.App_UserControls.ProductListCustomFilters" %>

<%@ Register Assembly="ZAScontrols"        Namespace="ZAScontrols"        TagPrefix="zas" %>

<asp:Panel runat="server" Visible="false">
    <asp:Panel ID="panelCustomFilters" runat="server" CssClass="filterStockAndPicture">
        <zas:ZasCheckBoxForFilters ID="cbxFilterOnlyOnStock" runat="server" Visible="false" DbWhere="and (data.zasoba_celkem>0)" DbWhereIsOuter="true" AutoPostBack="true" Text="<%$ Resources: Resource, FiltersOnlyStockFilter %>" />
        <zas:ZasCheckBoxForFilters ID="cbxFilterOnlyWithPicture" runat="server" Visible="false" DbWhere="and exists(select 1 from dba.attach_store a(index pk_attach_store) where a.tabulka='nomenklatura' and a.pk=nomen.id_nomen and a.att_class in ('ZSHOP_PICTURE','ZSHOP_PICTURE_DET','ZSHOP_PICTURE_SEZ'))" AutoPostBack="true" Text="<%$ Resources: Resource, FiltersOnlyWithPicturekFilter %>" />

        <zas:ZasCheckBoxForFilters ID="ZasCheckBoxForFilters1" runat="server" Visible="false" DbWhere="and 1=2" AutoPostBack="true" Text="Test" UseOnlyFor="Category=x117,Category=x26,NextCategory=xP5"/>
        <zas:ZasCheckBoxForFilters ID="ZasCheckBoxForFilters2" runat="server" Visible="false" DbWhere="and 1=2" AutoPostBack="true" Text="Test" />

        <zas:ZasDropDownListForFilters runat="server" Visible="false" SaveValueToSession="false"
            DbWhere="and 1={0}" DbWhereIsOuter="false"
            UseForPage="Category"
            xUseOnlyFor="Category=x117,Category=x26,NextCategory=xP5"
            AutoPostBack="true">
            <asp:ListItem Value="0" Text="test 0" />
            <asp:ListItem Value="1" Text="test 1" Selected="true" />
            <asp:ListItem Value="2" Text="test 2" />
        </zas:ZasDropDownListForFilters>

        <asp:PlaceHolder ID="phPriceFilter" runat="server" Visible="false">
            <div>
                <asp:TextBox ID="priceFrom" runat="server" />
                <asp:TextBox ID="priceTo" runat="server" AutoPostBack="true" />
                <asp:LinkButton ID="priceFilter" runat="server" OnClientClick="__doPostBack(null,'')">Filtruj</asp:LinkButton>
            </div>
        </asp:PlaceHolder>
        
    </asp:Panel>
</asp:Panel>