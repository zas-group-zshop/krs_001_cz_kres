<%@ Page Language="C#" MasterPageFile="~/ZASshop.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="ZASshop.NET.ProductDetail" EnableEventValidation="false" %>

<%@ Register Assembly="ZAScontrols"        Namespace="ZAScontrols"        TagPrefix="zas" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<script type="text/javascript" src="/App_Firma/js/jquery-ui-1.11.4.min.js"></script>
	<link href="/App_Firma/js/jquery-ui.css" rel="stylesheet" type="text/css" media="screen" />
	<script type="text/javascript" src="/App_Firma/js/jquery-magnificpopup.min.js"></script>
	<script type="text/javascript" src="/App_Firma/js/slick.min.js"></script>
	<script type="text/javascript">

	    function pageLoad() {

	        //popupCart();

	        $('.product-detail-images').magnificPopup({
			  	delegate: 'a',
			  	type: 'image',
			  	gallery: {
					enabled: true, // set to true to enable gallery
					preload: 0,
				  	navigateByImgClick: true,
				  	arrowMarkup: '<button title="%title%" type="button" class="mfp-arrow mfp-arrow-%dir%"></button>', // markup of an arrow button
				  	tPrev: 'Předchozí', // title for left button
				  	tNext: 'Další', // title for right button
				  	tCounter: '<span class="mfp-counter">%curr% z %total%</span>' // markup of counter
				}
			});

			$(".product-detail-slider").slick({
			  	infinite: false,
			  	slidesToShow: 3,
			  	slidesToScroll: 1,
			  	prevArrow: '<div type="button" class="slick-prev"><i class="fa fa-arrow-circle-left"></i></div>',
			  	nextArrow: '<div type="button" class="slick-next"><i class="fa fa-arrow-circle-right"></i></div>',
			});

	        $('#productTabs').tabs({
	        	activate: function( event, ui ) {
	        		var href = $("a", ui.newTab).attr("href");
	        		if(history.pushState) {
	        		    history.pushState(null, null, href);
	        		}
	        		else {
	        		    location.hash = href;
	        		}
	        	}
	        });
	    }
	</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ZasShopBodyPlaceHolder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                <ProgressTemplate>
                    <div class="dynamicPopulate_Updating">
                        
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>

			<!-- productDetail -->
			<div class="productDetail product-detail">

				<div class="row">
                                        <div class="col-md-12">
                                            <div class="pageDesc page-description">
                                                <h1><%= EvalDataFromXml("nazev") %></h1>
                                            </div>
                                        </div>
					<div class="col-md-5 product-detail-right">
						
						<!-- productContent -->
						<div class="productContent product-content">
							<div class="pageDesc page-description">
								<div class="page-description-text"><%= EvalDataFromXml("zkraceny_popis") %></div>
							</div>

							<div class="productBox">
								<table cellpadding="0" cellspacing="0" border="0" class="params table table-condensed table-striped">
									<tbody>
										<tr class='<%= String.IsNullOrEmpty(EvalDataFromXml("kod_vyrobce").ToString()) ? "hide-control" : "" %>'>
											<th><asp:Literal ID="lManufacturer" runat="server" Text="<%$ Resources: Resource, ProductManufacturer %>" />:</th>
											<td><%= EvalDataFromXml("nazev_vyrobce")%></td>
										</tr>
										<tr>
											<th><asp:Literal ID="Literal2" runat="server" Text="<%$ Resources: Resource, ProductStock %>" />:</th>
											<td><%= EvalDataFromXml("web_items_stav_skladu")%></td>
										</tr>
										<asp:PlaceHolder ID="phHod" runat="server" Visible="false">
										<tr>
											<th><asp:Literal ID="lRating" runat="server" Text='<%$ Resources: Resource, ProductRating %>' />:</th>										
		                                    <td><%= EvalDataFromXml("web_items_hodnoceni")%></td>
										</tr>
		                                </asp:PlaceHolder>
										<asp:PlaceHolder ID="phSl1" runat="server" Visible="false">
		                                    <tr>
											    <th><%= ZASutility.MyUtility.GetSession("n_sl_c1_popis") %>:</th>
											    <td><%= EvalDataFromXml("zshop_n_sl_c1")%></td>
										    </tr>
		                                </asp:PlaceHolder>
										<asp:PlaceHolder ID="phSl2" runat="server" Visible="false">
										    <tr>
											    <th><%= ZASutility.MyUtility.GetSession("n_sl_c2_popis") %>:</th>
											    <td><%= EvalDataFromXml("zshop_n_sl_c2")%></td>
										    </tr>
		                                </asp:PlaceHolder>
										<asp:PlaceHolder ID="phSl3" runat="server" Visible="false">
										    <tr>
											    <th><%= ZASutility.MyUtility.GetSession("n_sl_n1_popis") %>:</th>
											    <td><%= GetIntFromString(EvalDataFromXml("zshop_n_sl_n1"))%></td>
										    </tr>
		                                </asp:PlaceHolder>
										<asp:PlaceHolder ID="phSl4" runat="server" Visible="false">
										    <tr>
											    <th><%= ZASutility.MyUtility.GetSession("n_sl_n2_popis") %>:</th>
											    <td><%= GetIntFromString(EvalDataFromXml("zshop_n_sl_n2"))%></td>
										    </tr>
		                                </asp:PlaceHolder>
										<tr>
		                                    <th><%= Resources.Resource.ProductId %>:</th>
											<td><%= EvalDataFromXml("cislo_nomenklatury")%></td>
										</tr>
									</tbody>
								</table>
							</div>

							<div class="product-detail-box product-detail-parameters">

			                    <!-- productAtributes -->
			                    <asp:Panel ID="pAtributes" runat="server" CssClass="productBox form-inline">
									<asp:PlaceHolder ID="phAtributesKomb" runat="server">

										<div class="form-group">
				                            <label class="atr-komb-label"><asp:Literal ID="Literal7" runat="server" Text="<%$ Resources: Resource, AttributesCombLabel %>" />:</label>
				                            <%-- <div class="atr-komb-div"> --%>
				                                <zas:ZasAtributSelector ID="ddlAtributKomb" runat="server" AtributPoradi="0" AutoPostBack="true" CssClass="atr-komb-sel form-control" />
				                            <%-- </div> --%>
			                            </div>
			                        </asp:PlaceHolder>
									<asp:PlaceHolder ID="phAtributesDdl" runat="server">
			                            <table cellpadding="0" cellspacing="0" border="0" class="params">
										    <tbody>
											    <asp:PlaceHolder ID="phAtribut1" runat="server">
			    							        <tr>
												        <th><%= EvalDataFromXml("atribut_1_nazev")%></th>
			                                            <td class="productSelect">
			                                                <zas:ZasAtributSelector ID="ddlAtribut1" runat="server" AtributPoradi="1" AutoPostBack="true" />
			                                            </td>
											        </tr>
			                                    </asp:PlaceHolder>
											    <asp:PlaceHolder ID="phAtribut2" runat="server">
											        <tr>
												        <th><%= EvalDataFromXml("atribut_2_nazev")%></th>
			                                            <td class="productSelect">
			                                                <zas:ZasAtributSelector ID="ddlAtribut2" runat="server" AtributPoradi="2" AutoPostBack="true" />
			                                            </td>
											        </tr>
			                                    </asp:PlaceHolder>
											    <asp:PlaceHolder ID="phAtribut3" runat="server">
			                                        <tr>
												        <th><%= EvalDataFromXml("atribut_3_nazev")%></th>
			                                            <td class="productSelect">
			                                                <zas:ZasAtributSelector ID="ddlAtribut3" runat="server" AtributPoradi="3" AutoPostBack="true" />
			                                            </td>
											        </tr>
			                                    </asp:PlaceHolder>
										    </tbody>
									    </table>
			                        </asp:PlaceHolder>

			                        <div class="product-detail-attributes">
				                        <asp:Panel ID="pAtributesBtns" runat="server" CssClass="">
				                            <asp:Panel ID="pAtributesBtn1" runat="server" CssClass="atr-btns" btnCssClass="atr-btn btn btn-sm btn-default" btnCssClassActive="atr-btn btn btn-sm btn-default" />
				                            <asp:Panel ID="pAtributesBtn2" runat="server" CssClass="atr-btns" btnCssClass="atr-btn btn btn-sm btn-default" btnCssClassActive="atr-btn btn btn-sm btn-default-active btn-default" />
				                            <asp:Panel ID="pAtributesBtn3" runat="server" CssClass="atr-btns" btnCssClass="atr-btn btn btn-sm btn-default" btnCssClassActive="atr-btn btn btn-sm btn-default-active btn-default" />
				                        </asp:Panel>
				                    </div>
			                    </asp:Panel>
			                    <!-- /productAtributes -->

			                </div>

			                <div class="product-detail-box product-detail-cart">

								<div class="productBox">

									<div class="product-detail-price text-center" data-user_ref_cena_s_dph='<%= ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("web_items_cena_s_dph")) %>'>
										<asp:PlaceHolder runat="server" Visible="false" ID="phProductPriceLabel">
                                            <div class="priceLabel"><asp:Literal ID="lProductPriceLabel" runat="server" Text="<%$ Resources: Resource, ProductPrice %>" /></div>
                                        </asp:PlaceHolder>

                                                                            <%if(ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("user_ref_cena_s_dph")) > 0 && ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("web_items_cena_s_dph")) > 0 && Math.Round(ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("user_ref_cena_s_dph")), 2) != Math.Round(ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("web_items_cena_s_dph")), 2)){%>
                                                                                <div class="priceList old-price-with-vat">
                                                                                    <asp:PlaceHolder ID="phOldPriceWithDph" runat="server">
				    							<del>Běžná cena: <%= GetFormatPrice(ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("user_ref_cena_s_dph")))%></span><span class="dph">&nbsp;<%= GetFormatCurrency(EvalDataFromXml("id_meny"))%><br />
                                                                                    </asp:PlaceHolder>                                                                                
                                                                                </div>
                                                                            <% } %>

										<div class="priceList price-with-vat">
											<asp:PlaceHolder ID="phPriceWithDph" runat="server">
				    							<span class="price"><%= GetFormatPrice(ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("web_items_cena_s_dph")))%></span>&nbsp;<span class="prize_dph"><%= GetFormatCurrency(EvalDataFromXml("id_meny"))%>&nbsp;<%= Resources.Resource.ProductPriceWithTax %></span><br />
				                            </asp:PlaceHolder>
										</div>

										<div class="price-without-vat">
											<asp:PlaceHolder ID="phPriceWithoutDph" runat="server">
				                                <span class="dph"><%= GetFormatPrice(ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("web_items_cena_bez_dph")))%></span>&nbsp;<span class="dph"><%= GetFormatCurrency(EvalDataFromXml("id_meny"))%>&nbsp;<%= Resources.Resource.ProductPriceWithoutTax %></span><br />
				                            </asp:PlaceHolder>
											<asp:PlaceHolder ID="phDualPrice" runat="server" Visible="false">							
											    <span class="eura">
				                                    <asp:PlaceHolder ID="phDualPriceSDph" runat="server">
												    <span class="price"><%= GetDualPrice(ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("web_items_cena_mistni_s_dph")))%></span> <%= GetFormatCurrency(ZASutility.MyUtility.GetSession("id_dualni_meny")) %> <%= Resources.Resource.ProductPriceWithTax %> <br />
												    </asp:PlaceHolder>
				                                    <asp:PlaceHolder ID="phDualPriceBezDph" runat="server">
				                                    <span class="dph"><%= GetDualPrice(ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("web_items_cena_mistni_bez_dph")))%></span> <%= GetFormatCurrency(ZASutility.MyUtility.GetSession("id_dualni_meny")) %> <%= Resources.Resource.ProductPriceWithoutTax %>
				                                    </asp:PlaceHolder>
											    </span>
				                            </asp:PlaceHolder>
				                        </div>
									</div>

			                        <asp:Panel ID="pAddToBasket" runat="server" CssClass="addToBasket add-to-basket">
			                            <asp:TextBox ID="tbQuantity" runat="server" Text="1" MaxLength="5" CssClass="form-control" />
			                            <zas:IntoBasketButton ID="btIntoBasket" runat="server" CssClass="button btn btn-basic" ToolTip=""
			                                Text="<%$ Resources: Resource, BasketInsertItem %>" EnableViewState="true" ViewStateMode="Enabled"
			                                TbQuantityId="tbQuantity"
			                                Atribut1Id="ddlAtribut1" Atribut2Id="ddlAtribut2" Atribut3Id="ddlAtribut3"
			                                OnClick="btIntoBasket_Click" />
			                        </asp:Panel>
								</div>
							</div>

						</div>
						<!-- /productContent -->
					</div>

					<div class="col-md-7">

					<%if(EvalDataFromXml("akce_typ").ToString() == "10"){%>
                                            <ul>
                                                <li class='badge badge<%= EvalDataFromXml("akce_typ")%>'><asp:Literal ID="Action10" runat="server" Text="<%$ Resources: Resource, ActionTypeNewsName %>" /></li>
                                            </ul>
                                        <% } %>

                                        <%if(EvalDataFromXml("akce_typ").ToString() == "12"){%>
                                            <ul>
                                                <li class='badge badge<%= EvalDataFromXml("akce_typ")%>'><asp:Literal ID="Action12" runat="server" Text="<%$ Resources: Resource, ActionTypeActionName %>" /></li>
                                            </ul>
                                        <% } %>

                                        <%if(EvalDataFromXml("akce_typ").ToString() == "20"){%>
                                            <ul>
                                                <li class='badge badge<%= EvalDataFromXml("akce_typ")%>'><asp:Literal ID="Action20" runat="server" Text="<%$ Resources: Resource, ActionTypeSellOutName %>" /></li>
                                            </ul>
                                        <% } %>
                                        <%if(ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("user_ref_cena_s_dph")) > 0 && ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("web_items_cena_s_dph")) > 0 && Math.Round(ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("user_ref_cena_s_dph")), 2) != Math.Round(ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("web_items_cena_s_dph")), 2)){%>
                                            <span class="percent"><%= "-"+String.Format("{0:0}",((ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("user_ref_cena_s_dph"))-ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("web_items_cena_s_dph")))/ZASutility.MyUtility.StringToNumeric(EvalDataFromXml("user_ref_cena_s_dph")))*100)+"%"%></span>
                                        <% } %>

						<asp:PlaceHolder ID="phFor_ProductDetailPictures" runat="server" Visible="true"></asp:PlaceHolder>

						<div class="productButtons product-buttons">
                            <asp:Button ID="btnSendMail" runat="server" Text="<%$ Resources: Resource, ProductSendMail %>" CssClass="btn btn-primary btn-xs buttonEmail gray" Visible="true" ToolTip="<%$ Resources: Resource, ProductSendMailDesc1 %>"/>
                            <asp:Button ID="btnCompare" runat="server" Text="<%$ Resources: Resource, Compare %>" CssClass="btn btn-primary btn-xs buttonCompare gray" ToolTip="<%$ Resources: Resource, CompareToolTip %>"  />
                            <asp:Button ID="btnCompareView" runat="server" Text="<%$ Resources: Resource, CompareShow %>" CssClass="btn btn-primary btn-xs buttonCompare gray" Visible="true" />
                            <asp:Button ID="btnAddToShoppingList" runat="server" 
                                Text="<%$ Resources: Resource, AddToShoppingList %>" 
                                CssClass="btn btn-primary btn-xs buttonCompare gray" Visible="true" 
                                onclick="btnAddToShoppingList_Click" />
						</div>
					</div>
				</div>
			</div>
			<!-- /productDetail -->

            <!--varianty-->
            <asp:Panel ID="pProductList" runat="server">
                <h2><asp:Literal ID="Literal1" runat="server" Text="<%$ Resources: Resource, ProductDetailVariantsTitle %>"/></h2>
                <div class="ProductListList">
                    <asp:PlaceHolder ID="phVariants" runat="server" />
                </div>
            </asp:Panel>

            <asp:PlaceHolder ID="phDetailExt" runat="server"></asp:PlaceHolder>

            <asp:PlaceHolder ID="phFor_ProductDetailRecommendedItems" runat="server" Visible="true"></asp:PlaceHolder>
												
            <div id="productTabs">
		        <ul>
			        <li>
                        <asp:PlaceHolder ID="phTabProductDetailDesc" runat="server">
                            <a href="#tab1"><asp:Literal ID="lTabProductDetailDesc" runat="server" Text="<%$ Resources: Resource, TabProductDetailDesc %>"/></a>
                        </asp:PlaceHolder>
                    </li>
			        <li>
                        <asp:PlaceHolder ID="phTabProductDetailParams" runat="server">
                            <a href="#tab2"><asp:Literal ID="lTabProductDetailParams" runat="server" Text="<%$ Resources: Resource, TabProductDetailParams %>"/></a>
                        </asp:PlaceHolder>
                    </li>
			        <li>
                        <asp:PlaceHolder ID="phTabProductDetailStock" runat="server">
                            <a href="#tab3"><asp:Literal ID="lTabProductDetailStock" runat="server" Text="<%$ Resources: Resource, TabProductDetailStock %>"/></a>
                        </asp:PlaceHolder>
                    </li>
			        <li>
                        <asp:PlaceHolder ID="phTabProductDetailDisc" runat="server">
                            <a href="#tab4"><asp:Literal ID="lTabProductDetailDisc" runat="server" Text="<%$ Resources: Resource, TabProductDetailDisc %>"/></a>
                        </asp:PlaceHolder>
                    </li>
			        <li>
                        <asp:PlaceHolder ID="phTabProductDetailAlt" runat="server">
                            <a href="#tab5"><asp:Literal ID="lTabProductDetailAlt" runat="server" Text="<%$ Resources: Resource, TabProductDetailAlt %>"/></a>
                        </asp:PlaceHolder>
                    </li>
			        <li>
                        <asp:PlaceHolder ID="phTabProductDetailDownloads" runat="server">
                            <a href="#tab6"><asp:Literal ID="lTabProductDetailDownloads" runat="server" Text="<%$ Resources: Resource, TabProductDetailDownloads %>"/></a>
                        </asp:PlaceHolder>
                    </li>
			        <li>
                        <asp:PlaceHolder ID="phTabProductDetailVideos" runat="server">
                            <a href="#tab7"><asp:Literal ID="lTabProductDetailVideos" runat="server" Text="<%$ Resources: Resource, TabProductDetailVideos %>"/></a>
                        </asp:PlaceHolder>
                    </li>
		        </ul>
														
                <div id="tab1">
                    <asp:Panel ID="Panel1" runat="server">
                        <zas:ZasPlaceHolderForTabs ID="phFor_ProductDetailDescription" runat="server" Visible="true" RelationHyperLink="phTabProductDetailDesc" />
                    </asp:Panel>
		        </div>
		        <div id="tab2">
                    <asp:Panel ID="Panel2" runat="server">
                        <zas:ZasPlaceHolderForTabs ID="phFor_ProductDetailParameters" runat="server" Visible="true" RelationHyperLink="phTabProductDetailParams" />
                    </asp:Panel>
		        </div>
		        <div id="tab3">
                    <asp:Panel ID="Panel3" runat="server">
                        <zas:ZasPlaceHolderForTabs ID="phFor_ProductDetailStockInfo" runat="server" Visible="true" RelationHyperLink="phTabProductDetailStock" />
                    </asp:Panel>
		        </div>
		        <div id="tab4">
                    <asp:Panel ID="Panel4" runat="server">
                        <zas:ZasPlaceHolderForTabs ID="phFor_ProductDetailDiscussion" runat="server" Visible="true" RelationHyperLink="phTabProductDetailDisc" />
                    </asp:Panel>
		        </div>
		        <div id="tab5">
                    <zas:ZasPlaceHolderForTabs ID="phFor_ProductDetailAlternateItems" runat="server" Visible="true" RelationHyperLink="phTabProductDetailAlt" />
		        </div>
		        <div id="tab6">
                    <asp:Panel ID="Panel6" runat="server">
                        <zas:ZasPlaceHolderForTabs ID="phFor_ProductDetailDownloads" runat="server" Visible="true" RelationHyperLink="phTabProductDetailDownloads" />
                    </asp:Panel>
		        </div>
		        <div id="tab7">
                    <asp:Panel ID="Panel7" runat="server">
                        <zas:ZasPlaceHolderForTabs ID="phFor_ProductDetailVideos" runat="server" Visible="true" RelationHyperLink="phTabProductDetailVideos" />
                    </asp:Panel>
		        </div>
            </div>
								
            <asp:PlaceHolder ID="phFor_ProductDetailContactForm" runat="server" Visible="true"></asp:PlaceHolder>

            <asp:Panel ID="SendMail_Panel" runat="server">
                <asp:ModalPopupExtender ID="SendMail_Panel_mpe" runat="server"
                    TargetControlID="btnSendMail" PopupControlID="SendMailAction"
                    DropShadow="true" BackgroundCssClass="modal" CancelControlID="hlStorno" />
                <asp:Panel ID="SendMailAction" runat="server" CssClass="modal-popup">
                    <!-- pageDesc -->
                    <div class="pageDesc modal-desc">

                        <div class="modal-title"><asp:Literal ID="lh1" runat="server" Text="<%$ Resources: Resource, ProductSendMailTitle %>"></asp:Literal></div>
                        <asp:Panel ID="pDescription" runat="server">
                            <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources: Resource, ProductSendMailDesc2 %>" />
                        </asp:Panel>

						<div class="contactForm modal-contact-form">
                            <fieldset>

							    <div class="formRow">
                                    <label>
                                        <asp:Literal ID="Literal5" runat="server" Text="<%$ Resources: Resource, BasketNomenName %>" />:
                                    </label>
                                    <strong><%= EvalDataFromXml("nazev") %></strong>
                                </div>

                            	<div class="row">
                            		<div class="col-sm-6">
									    <div class="formRow">
	                                        <label>
	                                            <asp:Literal ID="l3" runat="server" Text="<%$ Resources: Resource, ContactFormEmail %>" />:
	                                        </label>
										    <asp:TextBox ID="sm_email" runat="server" CssClass="form-control" />
	                                        <asp:FilteredTextBoxExtender ID="f_sm_email" runat="server"
	                                            TargetControlID="sm_email"
	                                            FilterType="Numbers,LowercaseLetters,UppercaseLetters,Custom"
	                                            ValidChars="@._-" />
	                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
	                                            ErrorMessage="<%$ Resources: Resource, RequiredField %>" ValidationGroup="sm-send" 
	                                            ControlToValidate="sm_email" SetFocusOnError="true" Display="Dynamic" CssClass="reguired-field-mess" />
	                                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
	                                            ControlToValidate="sm_email"
	                                            ValidationExpression="[A-Za-z0-9_-]+(\.[A-Za-z0-9_-]+)*@[A-Za-z0-9_-]+(\.[A-Za-z0-9_-]+)+"
	                                            ErrorMessage="<%$ Resources: Resource, E_mailWrongFormat %>" Display="Dynamic" SetFocusOnError="true" ValidationGroup="sm-send" />
	                                        <asp:TextBoxWatermarkExtender ID="tbweEmail" runat="server"
	                                            TargetControlID="sm_email"
	                                            WatermarkText="<%$ Resources: Resource, EmailWaterMarkSm %>" />
									    </div>
                            		</div>
                            		<div class="col-sm-6">                            
									    <div class="formRow">
	                                        <label><asp:Literal ID="l1" runat="server" Text="<%$ Resources: Resource, ContactFormName %>" />:</label>
	                                        <asp:TextBox ID="sm_jmeno" runat="server" CssClass="form-control" />
	                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
	                                            ErrorMessage="<%$ Resources: Resource, RequiredField %>" ValidationGroup="sm-send"
	                                            ControlToValidate="sm_jmeno" SetFocusOnError="true" Display="Dynamic" CssClass="reguired-field-mess" />
									    </div>
                            		</div>
                            	</div>

                            	<div class="row">
                            		<div class="col-sm-12">						
									    <div class="formRow">
		                                    <label><em><asp:Literal ID="l5" runat="server" Text="<%$ Resources: Resource, SmTextOfMessage %>" />:</em></label>
										    <asp:TextBox ID="sm_zprava" runat="server" Columns="50" Rows="5" TextMode="MultiLine" CssClass="form-control" />
									    </div>
                            		</div>
                            	</div>
						    
							
                            </fieldset>
                        </div>

				        <!-- cartButtons -->
				        <div class="cartButtons modal-buttons">
	                        <asp:Button ID="btSend" runat="server" CssClass="button btn btn-basic btn-sm" 
	                            Text="<%$ Resources: Resource, ProductSendMail %>" ValidationGroup="sm-send" 
	                            OnClick="btSend_Click" />
	                        <asp:HyperLink  ID="hlStorno"   runat="server" CssClass="button btn btn-default btn-sm" Text="<%$ Resources: Resource, BtnStorno %>" />
				        </div>
				        <!-- /cartButtons -->

                    </div>
                    <!-- /pageDesc -->
                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="AfterAction_Panel" runat="server">
                <asp:Button ID="FakeBtnAction" runat="server" CssClass="hide-control" />
                <asp:ModalPopupExtender ID="AfterAction_mpe" runat="server"
                    TargetControlID="FakeBtnAction" PopupControlID="AfterAction" CancelControlID="hlAfterBack"
                    DropShadow="true" BackgroundCssClass="modal" />
                <asp:Panel ID="AfterAction" runat="server" CssClass="modal-popup">
                    <!-- pageDesc -->
                    <div class="pageDesc modal-desc">
                        <div class="modal-title"><asp:Literal ID="Literal4" runat="server" Text="<%$ Resources: Resource, ProductSendMailTitle %>"></asp:Literal></div>
                        <asp:Panel ID="Panel5" runat="server">
                            <br />
                            <asp:Literal ID="Literal6" runat="server" Text="<%$ Resources: Resource, SmSuccessText %>" />
                            <br />
                            <br /><br />
                        </asp:Panel>
                    </div>
                    <!-- /pageDesc -->

			        <!-- cartButtons -->
			        <div class="cartButtons modal-buttons">
                        <asp:HyperLink ID="hlAfterBack" CssClass="button btn btn-default btn-sm" runat="server" Text="<%$ Resources: Resource, CloseWindow %>" />
			        </div>
			        <!-- /cartButtons -->
                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="ShoppingListAdd_Panel" runat="server">
                <asp:Button ID="FakeBtnShoppingListAdd" runat="server" CssClass="hide-control" />
                <asp:ModalPopupExtender ID="ShoppingListAdd_mpe" runat="server"
                    TargetControlID="FakeBtnShoppingListAdd" PopupControlID="AfterShoppingListAdd" CancelControlID="hlAfterBackShoppingListAdd"
                    DropShadow="true" BackgroundCssClass="modal" />
                <asp:Panel ID="AfterShoppingListAdd" runat="server" CssClass="modal-popup">
                    <!-- pageDesc -->
                    <div class="pageDesc modal-desc">
                        <div class="modal-title"><asp:Literal ID="lShoppingListAdd" runat="server" Text="<%$ Resources: Resource, ShopingListsTitle %>"></asp:Literal></div>
                        <asp:Panel ID="pShoppingListAdd" runat="server">
                            <asp:PlaceHolder ID="phShoppingListSelect" runat="server">
                                <p><asp:DropDownList ID="ddlShoppingLists" runat="server" CssClass="form-control" /></p>
                                <br />
                                <p><asp:Literal ID="Literal8" runat="server" Text="<%$ Resources: Resource, ShopingListsSelectOr %>" /></p>
                            </asp:PlaceHolder>
                            <p><asp:Literal ID="lShopingListsNothing" runat="server" Text="<%$ Resources: Resource, ShopingListsNothing %>" /></p>
                            <asp:PlaceHolder ID="phShoppingListNew" runat="server">
                                <p><asp:Literal ID="lShopingListsOptional" runat="server" Text="<%$ Resources: Resource, ShoppingListNameOptional %>" /></p>
                                <asp:TextBox ID="tbShoppingListName" runat="server" MaxLength="40" CssClass="form-control"></asp:TextBox>
                            </asp:PlaceHolder>
                        </asp:Panel>
                    </div>
                    <!-- /pageDesc -->

			        <!-- cartButtons -->
			        <div class="cartButtons modal-buttons">
                        <asp:Button ID="btnAddItemToShoppingLists" CssClass="button btn btn-basic btn-sm" runat="server" 
                            Text="<%$ Resources: Resource, ShoppingListAddItem %>" 
                            onclick="btnAddItemToShoppingLists_Click" />
                        <asp:HyperLink ID="hlAfterBackShoppingListAdd" CssClass="button btn btn-default btn-sm" runat="server" Text="<%$ Resources: Resource, CloseWindow %>" />
			        </div>
			        <!-- /cartButtons -->
                </asp:Panel>
            </asp:Panel>

            <!-- //DOPLNIT ...pozdeji zahodit, ted nechat uplne nakonci -->
            <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Rows="15" Columns="50" Enabled="false" ReadOnly="true" Visible="false"></asp:TextBox>
		
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
