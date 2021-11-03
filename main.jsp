<%@page import="com.model.reportDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.model.reportDAO"%>

<%@page import="com.model.memberDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>DaeB</title>
<meta charset="EUC-KR" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="../assets/css/main.css" />
<noscript>
	<link rel="stylesheet" href="../assets/css/noscript.css" />
</noscript>

</head>
<body class="is-preload">
`
<%
	memberDTO dto = (memberDTO)session.getAttribute("dto");	
%>

	<!-- Wrapper-->
	<div id="wrapper">

		<!-- Nav -->
		<nav id="nav">
			<a href="#home" class="icon solid fa-home"><span>Home</span></a> <a
				href="#company" class="icon solid fa-bold"><span>About</span></a> <a
				href="#product" class="icon solid fa-fire"><span>Product</span></a> <a
				href="#report" class="icon solid fa-bullhorn"><span>Report</span></a>
			<a href="#contact" class="icon solid fa-comments-dollar"><span>Contact</span></a>
		</nav>
		<!-- Main -->
		<div id="main">

			<!-- Me -->
			<article id="home" class="panel intro">
				<header>
					<h1>로고</h1>
					<p>부연설명</p>
				</header>
				<!-- <a href="#work" class="jumplink pic">  -->
					<span class="arrow icon solid fa-chevron-right">
					<span> 사진</span>
					</span> <img src="images/me.jpg" alt="" />
				<!-- </a> -->
			</article>
			<article id="company" class="panel intro">
				<header>
					<h1>화생방</h1>
					<p>화재로부터 생명을 구하는 방법</p>
				</header>
				<div>
					<!-- <a> -->
					<!-- class="jumplink pic" -->
					<!-- <span class="arrow icon solid fa-chevron-right"> -->
					<!-- <span>See my work</span> -->
					<!-- </span> -->
					<!-- <img src="images/me.jpg" alt="" /> -->
					<!-- </a> -->
				</div>
			</article>

			<!-- 제품 소개 -->
			<article id="product" class="panel">
				<header>
					<h1> 제품 소개 </h1>
					<h3> 대#ㅣ</h3>
					<p>이 부분은 아마 전부 이미지로 대체하지 않을까..</p>
				</header>
				<p>화재 시 대피 시스템</p>
				<section>
					<div class="row">
						<div class="col-12-small">
							<a href="#" class="image fit"><img src="images/pic01.jpg" alt=""></a> 
								<span> 
								1. 보다 빠르게, 정확하게
								<p> 연기와 열을 동시에 감지하여 더 빠르고 정확한 화재 알림</p> 
								</span>
						</div>
					</div>
				</section>
			</article>




			<!-- 고장신고(report) -->
			<!-- ReportServiceCon에서 입력된 값 받아서 DB에 저장하기 -->
			<article id="report" class="panel">
				<header>
					<h2>고장 신고</h2>
					<p>고장신고를 해주신 분들께 소정의 상품을 드립니다</p>
				</header>
				<form action="WriteReport.do" method="post" enctype="multipart/form-data">
					<div>
						<div class="row">
							<div class="col-6">
								<input type="text" name="report_name" placeholder="이름" />
							</div>
							<div class="col-6">
								<input type="text" name="report_tel" placeholder="전화번호" />
							</div>
							
							<!-- 파일첨부 추가 -->
							<input type='file' name="report_filename"  accept="image/*" onchange="setThumbnail1(event);" />
							<div id="image_container1"></div>
							
							<div class="col-12">
								<input type="text" name="report_title" placeholder="제목" />
							</div>
							<div class="col-12">
							<form>
								<textarea name="report_content" placeholder="내용" rows="6"
									style="resize: none;" onKeyUp="javascript:fnChkByte(this,'1000')">
건물명 : 
건물주소 : 
제품번호 : 
상세내용 : </textarea>
									<span id="byteInfo">0</span> 1000bytes
									</form>
							</div>
							<div class="col-12" align="right">
								<input type="submit" value="작성" />
							</div>
						</div>
					</div>
				</form>
			</article>			
							
			<!-- Contact -->
			<!-- ContactServiceCon에서 입력된 값 받아서 DB에 저장하기 -->
			<article id="contact" class="panel">
				<header>
					<h2>구매·대여 문의</h2>
				</header>
				<form action="ContactServiceCon.do" method="post" enctype="multipart/form-data">
					<div>
						<div class="row">
							<div class="col-6">
								<input type="text" name="name" placeholder="이름" />
							</div>
							<div class="col-6">
								<input type="text" name="tel" placeholder="전화번호" />
							</div>
							
							<!-- 파일첨부 추가 -->
							<input type="file" name="fileName" id="image" accept="image/*" onchange="setThumbnail(event);" />
							<div id="image_container"></div>
							
							<div class="col-12">
								<input type="text" name="title" placeholder="제목" />
							</div>
							<div class="col-12">
							<form>
								<textarea name="content" placeholder="내용" rows="6"
									style="resize: none;" onKeyUp="javascript:fnChkByte1(this,'1000')">
건물명 : 
건물주소 : 
제품번호 : 
상세내용 :</textarea>
<span id="byteInfo1">0</span> 1000bytes
</form>
							</div>
							<div class="col-12" align="right">
								<input type="submit" value="문의" />
							</div>
						</div>
					</div>
				</form>
			</article>


		</div>

		<!-- Footer -->
		<div id="footer">
			<ul class="copyright">
				<li>&copy; Untitled.</li>
				<li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
				<%if(dto!=null){ %>
				<li><a href="../intro/member.jsp">Main</a></li>
				<%}else { %>
				<li><a href="../intro/intro.jsp">Main</a></li>
				<%} %>
			</ul>
		</div>
	</div>

	<script type="text/javascript">

		function setThumbnail(event) {
			var reader = new FileReader();
			reader.onload = function(event) {
				var img = document.createElement("img");
				img.setAttribute("src", event.target.result);
				document.querySelector("div#image_container").appendChild(img);
			};
			reader.readAsDataURL(event.target.files[0]);
		}
		function setThumbnail1(event) {
			var reader = new FileReader();
			reader.onload = function(event) {
				var img = document.createElement("img");
				img.setAttribute("src", event.target.result);
				document.querySelector("div#image_container1").appendChild(img);
			};
			reader.readAsDataURL(event.target.files[0]);
		}
		
		function fnChkByte(obj, maxByte)
		{
		    var str = obj.value;
		    var str_len = str.length;


		    var rbyte = 0;
		    var rlen = 0;
		    var one_char = "";
		    var str2 = "";


		    for(var i=0; i<str_len; i++)
		    {
		        one_char = str.charAt(i);
		        if(escape(one_char).length > 4) {
		            rbyte += 2;                                         //한글2Byte
		        }else{
		            rbyte++;                                            //영문 등 나머지 1Byte
		        }
		        if(rbyte <= maxByte){
		            rlen = i+1;                                          //return할 문자열 갯수
		        }
		     }
		     if(rbyte > maxByte)
		     {
		        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
		        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
		        str2 = str.substr(0,rlen);                                  //문자열 자르기
		        obj.value = str2;
		        fnChkByte(obj, maxByte);
		     }
		     else
		     {
		        document.getElementById('byteInfo').innerText = rbyte;
		     }
		}
		
		function fnChkByte1(obj, maxByte)
		{
		    var str = obj.value;
		    var str_len = str.length;


		    var rbyte = 0;
		    var rlen = 0;
		    var one_char = "";
		    var str2 = "";


		    for(var i=0; i<str_len; i++)
		    {
		        one_char = str.charAt(i);
		        if(escape(one_char).length > 4) {
		            rbyte += 2;                                         //한글2Byte
		        }else{
		            rbyte++;                                            //영문 등 나머지 1Byte
		        }
		        if(rbyte <= maxByte){
		            rlen = i+1;                                          //return할 문자열 갯수
		        }
		     }
		     if(rbyte > maxByte)
		     {
		        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
		        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
		        str2 = str.substr(0,rlen);                                  //문자열 자르기
		        obj.value = str2;
		        fnChkByte(obj, maxByte);
		     }
		     else
		     {
		        document.getElementById('byteInfo1').innerText = rbyte;
		     }
		}
	</script>


	<!-- Scripts -->
	<script src="../assets/js/jquery.min.js"></script>
	<script src="../assets/js/browser.min.js"></script>
	<script src="../assets/js/breakpoints.min.js"></script>
	<script src="../assets/js/util.js"></script>
	<script src="../assets/js/main.js"></script>

</body>
</html>