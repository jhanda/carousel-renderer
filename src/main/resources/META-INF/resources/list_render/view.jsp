<%@ include file="/META-INF/resources/init.jsp" %>

<%
    CPContentHelper cpContentHelper = (CPContentHelper)request.getAttribute(CPContentWebKeys.CP_CONTENT_HELPER);
    CPInstanceHelper cpInstanceHelper = (CPInstanceHelper)request.getAttribute("cpInstanceHelper");
    CPDataSourceResult cpDataSourceResult = (CPDataSourceResult)request.getAttribute(CPWebKeys.CP_DATA_SOURCE_RESULT);
    List<CPCatalogEntry> cpCatalogEntries = cpDataSourceResult.getCPCatalogEntries();
%>

<c:choose>
    <c:when test="<%= !cpCatalogEntries.isEmpty() %>">
        <div class="glider-contain">
            <div class="glider">

        <%
            for (CPCatalogEntry cpCatalogEntry : cpCatalogEntries) {
                String friendlyURL = cpContentHelper.getFriendlyURL(cpCatalogEntry, themeDisplay);
                List<CPSku> cpSkus = cpCatalogEntry.getCPSkus();
                long cpInstanceId = cpSkus.get(0).getCPInstanceId();
                String thumbnailSrc = cpInstanceHelper.getCPInstanceThumbnailSrc(cpInstanceId);
        %>
                <div class="card" style="margin: 5px;">
                    <a href="<%= friendlyURL %>"><img class="card-img-top img-fluid" src="<%= thumbnailSrc %>"></a>
                    <div class="card-body">
                        <h5><a href="<%= friendlyURL %>"><%= cpCatalogEntry.getName() %></a></h5>
                    </div>
                </div>
        <%
            }
        %>
            </div>
            <button aria-label="Previous" class="glider-prev">
                <liferay-ui:icon icon="angle-left" markupView="lexicon" />
            </button>
            <button aria-label="Next" class="glider-next">
                <liferay-ui:icon icon="angle-right" markupView="lexicon" />
            </button>
            <div role="tablist" class="dots"></div>
        </div>
    </c:when>

    <c:otherwise>
        <div class="alert alert-info">
            <liferay-ui:message key="no-products-were-found" />
        </div>
    </c:otherwise>
</c:choose>

<script src="https://cdn.jsdelivr.net/npm/glider-js@1/glider.min.js"></script>

<script>

    new Glider(document.querySelector('.glider'), {
        slidesToShow:  5,
        slidesToScroll: 5,
        draggable: true,
        dots: '.dots',
        arrows: {
            prev: '.glider-prev',
            next: '.glider-next'
        }
    });

</script>