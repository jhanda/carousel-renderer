<%@ include file="/META-INF/resources/init.jsp" %>

<%
    CPContentHelper cpContentHelper = (CPContentHelper)request.getAttribute(CPContentWebKeys.CP_CONTENT_HELPER);
    CPInstanceHelper cpInstanceHelper = (CPInstanceHelper)request.getAttribute("cpInstanceHelper");
    CPDataSourceResult cpDataSourceResult = (CPDataSourceResult)request.getAttribute(CPWebKeys.CP_DATA_SOURCE_RESULT);

    List<CPCatalogEntry> cpCatalogEntries = cpDataSourceResult.getCPCatalogEntries();

    int counter = 0;
%>

<c:choose>
    <c:when test="<%= !cpCatalogEntries.isEmpty() %>">
        <div class="container text-center my-3">
            <div class="row mx-auto my-auto">
                <div id="<portlet:namespace />myCarousel" class="carousel slide w-100"  data-interval="false">
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
                    <a class="carousel-control-prev bg-dark w-auto" href="#<portlet:namespace />myCarousel" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next bg-dark w-auto" href="#<portlet:namespace />myCarousel" role="button" data-slide="next">
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

    $('#<portlet:namespace />myCarousel').carousel({
        interval: 10000
    })

    $('#<portlet:namespace />myCarousel .carousel-item').each(function(){

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