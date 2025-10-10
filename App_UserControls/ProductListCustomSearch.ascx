<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductListCustomSearch.ascx.cs" Inherits="ZASshop.NET.App_UserControls.ProductListCustomSearch" ViewStateMode="Enabled" EnableViewState="true" %>

<%@ Register Assembly="ZAScontrols"        Namespace="ZAScontrols"        TagPrefix="zas" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Panel runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                <ProgressTemplate>
                    <div class="dynamicPopulate_Updating">
                        
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
           
                <asp:Panel runat="server" ID="plcsPanel" DefaultButton="hlCustomSearchSearch" >
                    <!-- pageDesc -->
                    <div class="pageDesc" runat="server" visible="false">
                        <h1><asp:Literal ID="Literal3" runat="server" Text="<%$ Resources: Resource, FiltersCustomSearchTitle %>"></asp:Literal></h1>
                        <asp:Panel ID="Panel1" runat="server" cssClass="customSearchBox">
                            <br />
                            <asp:Literal ID="lDesc" runat="server" Text="<%$ Resources: Resource, FiltersCustomSearchDesc %>" />
                            <br /><br />
                            <br /><br />
                        </asp:Panel>
                    </div>
                    <!-- /pageDesc -->

                    <div class="custom-search-box hidden-xs">
                        <div class="customSearchBox">
                            
                            <asp:PlaceHolder ID="firm_filtry_1_ph" runat="server" Visible="true">
                                <div id="firm_filtry_1_label" runat="server">
                                    <span runat="server" id="firm_filtry_1_label_txt" class="vl-box-label">Skladem&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-up"></i></span>
                                </div>
                                <asp:Panel runat="server" ID="firm_filtry_1" class="vl-box">
                                    <div id="firm_filtry_1_body_1" class="vl-box-body vl-box-body-1">
                                        <ul id="firm_filtry_1_ul">
                                            <li><zas:ZasCheckBoxForFilters ID="f1" runat="server" DbWhere=" dba.z_stav_skladu_fce(z.id,z.stav_zasoby_atr,z.stav_zasoby_data, '', nomen.id_nomen, '', '', '')>0" Text="Pouze zboží skladem" /></li>
                                        </ul>
                                    </div>
                                    <div id="firm_filtry_1_body_2" class="vl-box-body vl-box-body-2">
                                    </div>
                                </asp:Panel>
                                <div class="vl-box-separator"></div>
                                <asp:CollapsiblePanelExtender ID="firm_filtry_1_cpe" runat="server" EnableViewState="true" ViewStateMode="Enabled"
                                        TargetControlID="firm_filtry_1" ExpandControlID="firm_filtry_1_label" CollapseControlID="firm_filtry_1_label"
                                        TextLabelID="firm_filtry_1_label_txt"
                                        CollapsedText="Filtry&nbsp;&nbsp;&nbsp;<i class='fa fa-angle-down'></i>"
                                        ExpandedText="Filtry&nbsp;&nbsp;&nbsp;<i class='fa fa-angle-up'></i>" />
                            </asp:PlaceHolder>

                            <asp:PlaceHolder ID="phCustomSearchForManufacturers" runat="server"></asp:PlaceHolder>
                            <asp:PlaceHolder ID="phCustomSearchForPrice" runat="server"></asp:PlaceHolder>
                            <asp:PlaceHolder ID="phCustomSearchForParams" runat="server"></asp:PlaceHolder>
                        </div>

                        <!-- cartButtons -->
                        <div class="cartButtons">
                            <asp:LinkButton ID="hlCustomSearchSearch"    CssClass="button gray btn btn-basic btn-sm"       runat="server" Text="<%$ Resources: Resource, FiltersCustomSearchSearch %>" OnClick="hlCustomSearchSearch_Click" />
                            <asp:LinkButton ID="hlCustomSearchBack"      CssClass="button button-filter-search"  
                                runat="server" Text="<%$ Resources: Resource, BtnStorno %>" 
                                onclick="hlCustomSearchBack_Click" />
                        </div>
                        <!-- /cartButtons -->
                    </div>
                    
                </asp:Panel>

            </ContentTemplate>
        </asp:UpdatePanel>

<script src="/App_Firma/js/jquery-ui.min.js"></script>
<link href="/App_Firma/js/jquery-ui.min.css" rel="stylesheet" type="text/css" media="screen" />
<link href="/App_Firma/js/jquery-ui.theme.min.css" rel="stylesheet" type="text/css" media="screen" />
<script>
function pageLoad() {
    $(".vl-box-slider").each(function() {
        var $slider = $(this),
            $parent = $(this).parents(".vl-box-body"),
            $input_from = $(".vl-box-txt-od", $parent),
            $input_to = $(".vl-box-txt-do", $parent),
            $range_from = parseInt($input_from.data("min-value")),
            $range_to = parseInt($input_to.data("max-value")),
            $value_from = parseInt($input_from.val().replace(/\s/g, "").replace(/,/g,'')),
            $value_to = parseInt($input_to.val().replace(/\s/g, "").replace(/,/g,'')),
            $step = $slider.data("step") != undefined ? $slider.data("step") : 1,
            $startVal = null,
            $endVal = null,
            $postBack = $slider.data("auto-post-back"),
            $code = $(".button-filter-search").attr("href");

            if ( $range_to % $step > 0 ) {
                $range_to = Math.ceil($range_to/$step) * $step;
            }

            $input_from.change(function() {
                $val = parseFloat($(this).val());
                if(isNaN($val) || $val < $range_from || $val > $range_to) {
                    $input_from.val($range_from);
                } else {
                    $input_from.val($val);
                }
                if ($postBack) {
                    eval($code);
                }
            });

            $input_to.change(function() {
                $val = parseFloat($(this).val());
                if(isNaN($val) || $val < $range_from || $val > $range_to) {
                    $input_to.val($range_from);
                } else {
                    $input_to.val($val);
                }
                if ($postBack) {
                    eval($code);
                }
            });

        $slider.slider({
            range: true,
            min: $range_from,
            max: $range_to,
            step: $step,
            values: [ $value_from, $value_to ],
            create: function( event, ui ) {
                $(this).children('.ui-slider-handle').first().addClass("slider-handle-left");
                $(this).children('.ui-slider-handle').last().addClass("slider-handle-right");
            },
            slide: function( event, ui ) {
                $input_from.val( ui.values[ 0 ] );
                $input_to.val( ui.values[ 1 ] );
            },
            change: function( event, ui ) {
                if($(ui.handle).hasClass("slider-handle-left")) {
                    if($startVal != ui.values[ 0 ]) {
                        // $input_from.change();
                        if ($postBack) {
                            eval($code);
                        }
                    } else {
                        // Prevented
                    }
                    
                } else {
                    if($endVal != ui.values[ 1 ]) {
                        // $input_to.change();
                        if ($postBack) {
                            eval($code);
                        }
                    } else {
                        // Prevented
                    }
                }
            },
            start: function( event, ui ) {
                if($(ui.handle).hasClass("slider-handle-left")) {
                    $startVal = ui.values[ 0 ];
                } else {
                    $endVal = ui.values[ 1 ];
                }
            }
        });
    });

    $(".vl-box-slider").parents(".vl-box").parent().css("height", "auto");
}
</script>
<script>
    // Weight box initial height fix
    setTimeout(function() {
        $(".vl-box-slider").parents(".vl-box").parent().css("height", "auto");
    }, 300);
</script>
</asp:Panel>