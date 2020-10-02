package com.liferay.commerce.demo.carousel.renderer.include;

import com.liferay.portal.kernel.servlet.taglib.DynamicInclude;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.liferay.portal.kernel.util.PortalUtil;
import org.osgi.service.component.annotations.Component;

/**
 * @author Jeff Handa
 */

@Component(immediate = true, service = DynamicInclude.class)
public class CarouselRendererInclude implements DynamicInclude {

    @Override
    public void include(
            HttpServletRequest request, HttpServletResponse response,
            String key)
            throws IOException {

        String portalURL = PortalUtil.getPortalURL(request);

        PrintWriter printWriter = response.getWriter();

        String content = "<link href=\"" + portalURL +
                "/o/carousel-renderer/css/main.css\"  " +
                "rel=\"stylesheet\" type = \"text/css\" />";

        printWriter.println(content);
    }

    @Override
    public void register(DynamicIncludeRegistry dynamicIncludeRegistry) {
        dynamicIncludeRegistry.register("/html/common/themes/top_head.jsp#pre");
    }
}
