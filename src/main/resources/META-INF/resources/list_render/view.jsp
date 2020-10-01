<%@ include file="/META-INF/resources/init.jsp" %>

<%
    CPContentHelper cpContentHelper = (CPContentHelper)request.getAttribute(CPContentWebKeys.CP_CONTENT_HELPER);
    CPInstanceHelper cpInstanceHelper = (CPInstanceHelper)request.getAttribute("cpInstanceHelper");
    CPDataSourceResult cpDataSourceResult = (CPDataSourceResult)request.getAttribute(CPWebKeys.CP_DATA_SOURCE_RESULT);

    List<CPCatalogEntry> cpCatalogEntries = cpDataSourceResult.getCPCatalogEntries();
    CommerceContext commerceContext = (CommerceContext)request.getAttribute(CommerceWebKeys.COMMERCE_CONTEXT);

%>
<c:choose>
    <c:when test="<%= !cpCatalogEntries.isEmpty() %>">
        <%
            for (CPCatalogEntry cpCatalogEntry : cpCatalogEntries) {
                String friendlyURL = cpContentHelper.getFriendlyURL(cpCatalogEntry, themeDisplay);
                List<CPSku> cpSkus = cpCatalogEntry.getCPSkus();
                long cpInstanceId = cpSkus.get(0).getCPInstanceId();
                 String thumbnailSrc = cpInstanceHelper.getCPInstanceThumbnailSrc(cpInstanceId);
            %>
            <div>
                <div>
                    <img src="<%= thumbnailSrc %>"></img>
                </div>
                <div>
                    <a href="<%= friendlyURL %>"><%= cpCatalogEntry.getName() %></a>
                </div>
            </div>
        <%
            }
        %>

    </c:when>

    <c:otherwise>
        <div class="alert alert-info">
            <liferay-ui:message key="no-products-were-found" />
        </div>
    </c:otherwise>
</c:choose>