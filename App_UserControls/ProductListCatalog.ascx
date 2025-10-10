<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductListCatalog.ascx.cs" Inherits="ZASshop.NET.ProductListCatalog" %>

<%@ Register Assembly="ZAScontrols"        Namespace="ZAScontrols"        TagPrefix="zas" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Panel runat="server" CssClass="productList product-list-catalog">
    <asp:Repeater ID="rProductListCatalog" runat="server" 
        OnItemCommand="rProductList_ItemCommand" 
        OnItemDataBound="rProductList_ItemDataBound" >
        <ItemTemplate>
            <asp:Panel ID="pProduktPanel" runat="server" CssClass='<%# "product" + (((Container.ItemIndex + 1) % 3 == 0) ? " mod-3" : "") + (((Container.ItemIndex + 1) % 4 == 0) ? " mod-4" : "") + (((Container.ItemIndex + 1) % 2 == 0) ? " mod-2" : "") %>'>                

                <div class="row">
                    <div class="col-sm-12">
                        <div class="product-list-image">
                            <a href="<%# DataBinder.Eval(Container.DataItem, "web_items_url") %>" title="<%# DataBinder.Eval(Container.DataItem, "nazev") %>">
                                <img src="<%# DataBinder.Eval(Container.DataItem, "web_items_preview_file") %>" alt="<%# DataBinder.Eval(Container.DataItem, "nazev") %>" />                                
                            </a>
                            <ul class="product-flags">
                                <li><span class="<%# DataBinder.Eval(Container.DataItem, "akce_typ").ToString() == "10" ? "badge mod-news" : (DataBinder.Eval(Container.DataItem, "akce_typ").ToString() == "12" ? "badge mod-action" : (DataBinder.Eval(Container.DataItem, "akce_typ").ToString() == "20" ? "badge mod-sellout" : "badge mod-none")) %>">
                                    <%# DataBinder.Eval(Container.DataItem, "akce_typ").ToString() == "10" ? ZASutility.MyUtility.GetLangResource("ActionTypeNewsName") : (DataBinder.Eval(Container.DataItem, "akce_typ").ToString() == "12" ? ZASutility.MyUtility.GetLangResource("ActionTypeActionName") : (DataBinder.Eval(Container.DataItem, "akce_typ").ToString() == "20" ? ZASutility.MyUtility.GetLangResource("ActionTypeSellOutName") : "")) %>
                                </span></li>                                
                            </ul>
                            <!--<div class="rating">
                                <%# DataBinder.Eval(Container.DataItem, "web_items_hodnoceni")%>
                            </div>-->

<asp:PlaceHolder ID="phPercent" runat="server" Visible='<%# Convert.ToDecimal(DataBinder.Eval(Container.DataItem, "user_ref_cena_s_dph")) > 0 && Convert.ToDecimal(DataBinder.Eval(Container.DataItem, "web_items_cena_s_dph")) > 0 && Math.Round(Convert.ToDecimal(DataBinder.Eval(Container.DataItem, "user_ref_cena_s_dph")), 2) != Math.Round(Convert.ToDecimal(DataBinder.Eval(Container.DataItem, "web_items_cena_s_dph")), 2) ? true: false %>'> 
    <div class="percent">
        <%# "-" + String.Format("{0:0}",((Convert.ToDecimal(DataBinder.Eval(Container.DataItem, "user_ref_cena_s_dph")) - Convert.ToDecimal(DataBinder.Eval(Container.DataItem, "web_items_cena_s_dph")))/Convert.ToDecimal(DataBinder.Eval(Container.DataItem, "user_ref_cena_s_dph")))*100)+"%" %>
    </div>
</asp:PlaceHolder>
                        </div>
                    </div>                    
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <h2 class="product-list-title">
                            <a href="<%# DataBinder.Eval(Container.DataItem, "web_items_url") %>"><%# DataBinder.Eval(Container.DataItem, "nazev") %></a>
                        </h2>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <!-- productRight -->                        
                        <div class="productRight product-list-right">
                            <div class="product-list-availability avail"><%# DataBinder.Eval(Container.DataItem, "web_items_stav_skladu") %></div>
                            <div class="priceInfo product-list-price-info">
                                <span class="<%# Convert.ToDecimal(DataBinder.Eval(Container.DataItem, "web_items_cena_s_dph")) > 0 && Math.Round(Convert.ToDecimal(DataBinder.Eval(Container.DataItem, "user_ref_cena_s_dph")), 2) != Math.Round(Convert.ToDecimal(DataBinder.Eval(Container.DataItem, "web_items_cena_s_dph")), 2) ? "product-list-price-old" : ("product-list-price-old none") %>">
                                        <del><%# ShowPrice("1", ZASutility.ShowPriceType.PriceOnly, DataBinder.Eval(Container.DataItem, "user_ref_cena_s_dph").ToString(), DataBinder.Eval(Container.DataItem, "id_meny").ToString()) %> <%# ShowPrice("1", ZASutility.ShowPriceType.CurrencyOnly, DataBinder.Eval(Container.DataItem, "user_ref_cena_s_dph").ToString(), DataBinder.Eval(Container.DataItem, "ref_cena_id_meny").ToString()) %></del>
                                    </span>                                
                                <span class="product-list-price price"><%# ShowPrice("1", ZASutility.ShowPriceType.PriceAndCurrency, DataBinder.Eval(Container.DataItem, "web_items_cena_s_dph").ToString(), DataBinder.Eval(Container.DataItem, "id_meny").ToString()) %></span>
                                <span class="product-list-vat dph"><%# ShowPrice("1", ZASutility.ShowPriceType.DescriptionOnly, String.Empty, String.Empty) %></span>
                                <asp:PlaceHolder ID="phDualPrice" runat="server" Visible="false">
                                    <span class="eura">
                                        <%# ShowPrice(DataBinder.Eval(Container.DataItem, "dph_anone").ToString(), ZASutility.ShowPriceType.PriceAndCurrency, GetDualPrice(ZASutility.MyUtility.StringToNumeric(DataBinder.Eval(Container.DataItem, "cena_mistni").ToString())).ToString(), ZASutility.MyUtility.GetSession("id_dualni_meny")) %>
                                        <span class="dph"><%# ShowPrice(DataBinder.Eval(Container.DataItem, "dph_anone").ToString(), ZASutility.ShowPriceType.DescriptionOnly, String.Empty, String.Empty) %></span>
                                    </span>
                                </asp:PlaceHolder>
                            </div>                        
                        </div>
                        <!-- /productRight -->
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="tools">
                            <asp:Button ID="hlCompare" runat="server" CssClass="compare" ToolTip="<%$ Resources: Resource, CompareToolTip %>" Text="<%$ Resources: Resource, Compare %>" CommandName="IntoCompare" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "cislo_nomenklatury") %>' />
                            <asp:Panel ID="pAddToBasket" runat="server" CssClass="addToBasket product-list-basket">

                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-inline">
                                            <asp:TextBox ID="tbQuantity" runat="server" Text="1" MaxLength="5" cssClass="form-control input-sm" />
                                            <zas:IntoBasketButton ID="btIntoBasket" runat="server" CssClass="button btn btn-basic btn-sm" CommandName="IntoBasket" ToolTip="<%$ Resources: Resource, BasketAfterInsertTitle %>" Text="<%$ Resources: Resource, BasketInsertItem %>" 
                                              TbQuantityId="tbQuantity"
                                              Atribut1Id="" Atribut2Id="" Atribut3Id=""
                                              Atribut1IdName='<%# DataBinder.Eval(Container.DataItem, "atribut_1_nazev") %>' Atribut2IdName='<%# DataBinder.Eval(Container.DataItem, "atribut_2_nazev") %>' Atribut3IdName='<%# DataBinder.Eval(Container.DataItem, "atribut_3_nazev") %>'
                                              Atribut1Prac='<%# DataBinder.Eval(Container.DataItem, "atribut_1_pracovat") %>' Atribut2Prac='<%# DataBinder.Eval(Container.DataItem, "atribut_2_pracovat") %>' Atribut3Prac='<%# DataBinder.Eval(Container.DataItem, "atribut_3_pracovat") %>'
                                              Atribut1Cis='<%# DataBinder.Eval(Container.DataItem, "atribut_1_cis") %>' Atribut2Cis='<%# DataBinder.Eval(Container.DataItem, "atribut_2_cis") %>' Atribut3Cis='<%# DataBinder.Eval(Container.DataItem, "atribut_3_cis") %>'
                                              Atribut1Req='<%# DataBinder.Eval(Container.DataItem, "atribut_1_povinnost") %>' Atribut2Req='<%# DataBinder.Eval(Container.DataItem, "atribut_2_povinnost") %>' Atribut3Req='<%# DataBinder.Eval(Container.DataItem, "atribut_3_povinnost") %>'
                                              AtributRozliseni='<%# DataBinder.Eval(Container.DataItem, "rozliseni") %>'
                                              IdNomen='<%# DataBinder.Eval(Container.DataItem, "id_nomen") %>'
                                              CisloNomen='<%# DataBinder.Eval(Container.DataItem, "cislo_nomenklatury") %>'
                                              TypAtributu='<%# DataBinder.Eval(Container.DataItem, "typ_atributu") %>'
                                              Nazev='<%# DataBinder.Eval(Container.DataItem, "nazev") %>'
                                              IdMj='<%# DataBinder.Eval(Container.DataItem, "id_mj") %>'
                                              Mj='<%# DataBinder.Eval(Container.DataItem, "mj") %>'
                                              Cena='<%# ZASutility.MyUtility.StringToNumeric(DataBinder.Eval(Container.DataItem, "cena")) %>'
                                              Dph='<%# DataBinder.Eval(Container.DataItem, "dph_anone").ToString()=="1" ? true : false %>'
                                              CenaMistni='<%# ZASutility.MyUtility.StringToNumeric(DataBinder.Eval(Container.DataItem, "cena_mistni")) %>'
                                              IdMeny='<%# DataBinder.Eval(Container.DataItem, "id_meny") %>'
                                              SazbaDph='<%# ZASutility.MyUtility.StringToNumeric(DataBinder.Eval(Container.DataItem, "sazba_dph")) %>'
                                              KoeficientDph='<%# ZASutility.MyUtility.StringToNumeric(DataBinder.Eval(Container.DataItem, "koeficient")) %>'
                                              ZasobaCelkem='<%# ZASutility.MyUtility.StringToNumeric(DataBinder.Eval(Container.DataItem, "zasoba_celkem")) %>' />  
                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <p class="desc"><%# DataBinder.Eval(Container.DataItem, "zkraceny_popis") %></p>
                    </div>
                </div>
                
                <span class="cislo"><%# DataBinder.Eval(Container.DataItem, "cislo_nomenklatury") %></span>

            </asp:Panel><!-- .product -->
            <!-- clearovaci div pro resp. design -->
            <asp:Panel runat="server" ID="clearDiv_2" CssClass="border-div clearfix home-clearfix" Visible='<%# ((Container.ItemIndex + 1) % 4 == 0) %>' />
            <asp:Panel runat="server" ID="clearDiv_3" CssClass="border-div clearfix hidden-xs hidden-sm visible-md-block visible-lg-block" Visible='<%# ((Container.ItemIndex + 1) % 3 == 0) %>' />
            <asp:Panel runat="server" ID="clearDiv_4" CssClass="border-div clearfix hidden-xs visible-sm-block hidden-md hidden-lg" Visible='<%# ((Container.ItemIndex + 1) % 2 == 0) %>' />
            <!-- clearovaci div pro resp. design -->
        </ItemTemplate>
    </asp:Repeater>

    <asp:Panel ID="AfterInsertIntoBasketAction_Panel" runat="server">
        <asp:Button ID="FakeBtnAction" runat="server" CssClass="hide-control hidden" />
        <asp:ModalPopupExtender ID="AfterInsertIntoBasketAction_mpe" runat="server"
            TargetControlID="FakeBtnAction" PopupControlID="AfterInsertIntoBasketAction"
            DropShadow="true" BackgroundCssClass="modal" CancelControlID="hlAfterBack" />
        <asp:Panel ID="AfterInsertIntoBasketAction" runat="server" CssClass="modal-popup">
            <!-- pageDesc -->
            <div class="pageDesc modal-desc">
                <div class="modal-title"><asp:Literal ID="lh1" runat="server" Text="<%$ Resources: Resource, BasketAfterInsertTitle %>"></asp:Literal></div>
                <asp:Panel ID="pDescription" runat="server" cssClass="cartPopupDesc">
                    <p><asp:Literal ID="Literal1" runat="server" Text="<%$ Resources: Resource, BasketAfterInsertDesc1 %>" /></p>
                    <p><strong><asp:Literal ID="Literal2" runat="server" Text="<%$ Resources: Resource, BasketAfterInsertDesc2 %>" /></strong></p>
                </asp:Panel>
            </div>
            <!-- /pageDesc -->

			<!-- cartButtons -->
			<div class="cartButtons modal-buttons" data-url='<%: Request.RawUrl %>'>
                <a href='<%: Request.RawUrl %>'   class="button btn btn-sm btn-default"><%: ZASutility.MyUtility.GetLangResource("BasketAfterActionBack") %></a>
                <asp:HyperLink ID="hlAfterBack"   CssClass="button btn btn-sm btn-default hide-control" runat="server" Text="<%$ Resources: Resource, BasketAfterActionBack %>" />
                <asp:HyperLink ID="hlAfterBasket" CssClass="button btn btn-sm btn-default" runat="server" NavigateUrl="~/kosik" Text="<%$ Resources: Resource, BasketAfterActionBasket %>" />
                <asp:HyperLink ID="hlAfterOrder"  CssClass="button btn btn-sm btn-basic"   runat="server" NavigateUrl="~/objednavka" Text="<%$ Resources: Resource, BasketAfterActionOrder %>" />
			</div>
			<!-- /cartButtons -->
        </asp:Panel>
    </asp:Panel>



    <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Rows="15" Columns="50" Enabled="false" ReadOnly="true" Visible="false"></asp:TextBox>
</asp:Panel>