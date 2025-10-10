<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MenuExtension.ascx.cs" Inherits="ZASshop.NET.App_UserControls.MenuExtension" %>

<%@ Register Assembly="ZAScontrols"        Namespace="ZAScontrols"        TagPrefix="zas" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<zas:ZASmenu ID="NextTreeInMenu" runat="server"
  CssClass = "MainMenu"
  MenuSourceXmlSessionName="trees_prepared"
  MenuSourceXmlFromSessionParams = "#DOCELEM;"
  MenuItemXPath = "skupiny_items/skupiny_item"
  MenuItemID = "id"
  MenuItemIntID = "int_id"
  MenuItemName = "nazev"
  MenuItemNameHtml = "nazev_html"
  MenuItemUrlGenerate = true
  MenuItemUrlPrefix = "url_prefix"
  MenuItemSeoName = "seo_nazev"
  MenuItemSeoNamePrefix = "top"
  MenuItemUrlGenerateForItem = "url_gen"
  MenuFromLevel = 3
  MenuDepthMax = 3
  MenuDepthDefault = 4
  MenuResultHtml="ul"
  MenuCurrentRootCssClass="active" MenuCurrentNodeCssClass="active" MenuCurrentItemCssClass="active"
  CreateUlIntoOuterDiv = "true"
  DepthForOuterDiv = 3
  CssClassForOuterDiv = "sub"
  cssClassForFirstLiInOuterDiv="menuTitle" />

