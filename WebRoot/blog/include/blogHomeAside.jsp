<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

  <aside>
    <div class="avatar"><a style="background: url(<%=session.getAttribute("userIcon") %>) no-repeat ;background-size:163px 163px; "  href="index.jsp?userId=<%=session.getAttribute("userId") %>"><span>我的首页</span></a></div>
    <div class="topspaceinfo">
      <h1>我是 <%=session.getAttribute("userName") %></h1>
      <p><%=session.getAttribute("userMotto") %></p>
    </div>
    <div class="about_c">
      <p>网名：<%=session.getAttribute("userName") %></p>
      <p>职业：<%=session.getAttribute("userJob") %> </p>
      <p>籍贯：<%=session.getAttribute("userHometown") %></p>
      <p>电话：<%=session.getAttribute("userTele") %></p>
      <p>邮箱：<%=session.getAttribute("userEmail") %></p>
    </div>
    <div class="bdsharebuttonbox"><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_more" data-cmd="more"></a></div>
    <jsp:include page="/blog/include/tj_news.jsp"></jsp:include>
    <jsp:include page="/blog/include/links.jsp"></jsp:include>
    <div class="copyright">
      <ul>
        <p> Design by <a>FaceBlog开发小组</a></p>
        </p>
      </ul>
    </div>
  </aside>
