<%@ page import="com.liferay.commerce.product.content.util.CPContentHelper" %>
<%@ page import="com.liferay.commerce.product.content.constants.CPContentWebKeys" %>
<%@ page import="com.liferay.commerce.product.util.CPInstanceHelper" %>
<%@ page import="com.liferay.commerce.product.data.source.CPDataSourceResult" %>
<%@ page import="com.liferay.commerce.product.constants.CPWebKeys" %>
<%@ page import="com.liferay.commerce.product.catalog.CPCatalogEntry" %>
<%@ page import="com.liferay.commerce.context.CommerceContext" %>
<%@ page import="com.liferay.commerce.constants.CommerceWebKeys" %>
<%@ page import="com.liferay.commerce.product.catalog.CPSku" %>
<%@ page import="java.util.List" %>
<%@ include file="/META-INF/resources/init.jsp" %>

<%
    CPContentHelper cpContentHelper = (CPContentHelper)request.getAttribute(CPContentWebKeys.CP_CONTENT_HELPER);
    CPInstanceHelper cpInstanceHelper = (CPInstanceHelper)request.getAttribute("cpInstanceHelper");
    CPDataSourceResult cpDataSourceResult = (CPDataSourceResult)request.getAttribute(CPWebKeys.CP_DATA_SOURCE_RESULT);

    List<CPCatalogEntry> cpCatalogEntries = cpDataSourceResult.getCPCatalogEntries();
    CommerceContext commerceContext = (CommerceContext)request.getAttribute(CommerceWebKeys.COMMERCE_CONTEXT);

    int counter = 0;

%>

<c:choose>
    <c:when test="<%= !cpCatalogEntries.isEmpty() %>">
        <div class="container text-center my-3">
            <div class="row mx-auto my-auto">
                <div id="myCarousel" class="carousel slide w-100"  data-interval="false">
                    <div class="carousel-inner w-100" role="listbox">

        <%
            for (CPCatalogEntry cpCatalogEntry : cpCatalogEntries) {
                String friendlyURL = cpContentHelper.getFriendlyURL(cpCatalogEntry, themeDisplay);
                List<CPSku> cpSkus = cpCatalogEntry.getCPSkus();
                long cpInstanceId = cpSkus.get(0).getCPInstanceId();
                String thumbnailSrc = cpInstanceHelper.getCPInstanceThumbnailSrc(cpInstanceId);
                String active = "active";

                if(counter > 0){
                    active ="";
                }
            %>

                    <div class="carousel-item <%= active%>">
                        <div class="col-lg-2">
                            <a href="<%= friendlyURL %>"><img class="img-fluid" src="<%= thumbnailSrc %>"></a>
                            <div class-"product-name">
                                <a href="<%= friendlyURL %>"><%= cpCatalogEntry.getName() %></a>
                            </div>
                        </div>
                    </div>

        <%
                counter++;
            }
        %>
                    </div>
                    <a class="carousel-control-prev bg-dark w-auto" href="#myCarousel" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next bg-dark w-auto" href="#myCarousel" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
        </div>
    </c:when>

    <c:otherwise>
        <div class="alert alert-info">
            <liferay-ui:message key="no-products-were-found" />
        </div>
    </c:otherwise>
</c:choose>


<script>

    console.log("In the script");
    $('#myCarousel').carousel({
        interval: 10000
    })

    $('.carousel .carousel-item').each(function(){

        console.log("In the item");

        var minPerSlide = 3;
        var next = $(this).next();
        if (!next.length) {
            next = $(this).siblings(':first');
        }
        next.children(':first-child').clone().appendTo($(this));

        for (var i=0;i<minPerSlide;i++) {
            next=next.next();
            if (!next.length) {
                next = $(this).siblings(':first');
            }

            next.children(':first-child').clone().appendTo($(this));
        }
    });
</script>