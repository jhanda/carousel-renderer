package com.liferay.commerce.demo.carousel.renderer.list;

import com.liferay.commerce.product.constants.CPPortletKeys;
import com.liferay.commerce.product.content.render.list.CPContentListRenderer;
import com.liferay.commerce.product.util.CPInstanceHelper;
import com.liferay.frontend.taglib.servlet.taglib.util.JSPRenderer;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.util.ResourceBundleUtil;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Locale;
import java.util.ResourceBundle;

/**
 * @author Cliff Sanchez
 * @author Jeff Handa
 */
@Component(
        immediate = true,
        property = {
                "commerce.product.content.list.renderer.key=" + CarouselProductListRenderer.KEY,
                "commerce.product.content.list.renderer.order=250",
                "commerce.product.content.list.renderer.portlet.name=" + CPPortletKeys.CP_PUBLISHER_WEB
        },
        service = CPContentListRenderer.class
)
public class CarouselProductListRenderer implements CPContentListRenderer {

    public static final String KEY = "carousel";

    @Override
    public String getKey() {
        return KEY;
    }

    @Override
    public String getLabel(Locale locale) {
        ResourceBundle resourceBundle = ResourceBundleUtil.getBundle(
                "content.Language", locale, getClass());

        return LanguageUtil.get(resourceBundle, "carousel");
    }

    @Override
    public void render(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {

        httpServletRequest.setAttribute("cpInstanceHelper", _cpInstanceHelper);

        _jspRenderer.renderJSP(
                _servletContext, httpServletRequest, httpServletResponse,
                "/META-INF/resources/list_render/view.jsp");
    }

    @Reference(
            target = "(osgi.web.symbolicname=com.liferay.commerce.demo.carousel.renderer)"
    )
    private ServletContext _servletContext;

    @Reference
    private JSPRenderer _jspRenderer;

    @Reference
    private CPInstanceHelper _cpInstanceHelper;
}