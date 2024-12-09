<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
        #kgw_frame {
            width: 900px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
        }
        .kgw_titleBox{
            width: 100%;
            height: auto;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: flex-start;
            gap: 16px;
        }
        .kgw_iconBox{
            width: 64px;
            margin-left: 11px;
            margin-top: 4px;
        }
        #kgw_icon{
            width: 100%;
        }
        .kgw_title {
            font-family: 'Pretendard';
            font-weight: 600;
            color: #3b1e54;
            font-size: 54px;
            display: flex;
            justify-content: flex-start;
            align-items: flex-start;
        }
        .kgw_detail{
        	width: 100%;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center; 
            gap: 12px;
            font-size: 20px;
        }
        .kgw_author{
            font-weight: 500;
            color: #000;
        }
        .kgw_divider{
            color: #000; 
        }
        .kgw_date{
            color: #000;
            font-weight: 400;
            font-size: 16px;
        }
        .kgw_theme{
            border-radius: 10px;
            background-color: #E3D2E7;
            color: #630C92;
            font-size: 16px;
            font-weight: 400;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 4px 16px;
        }
</style>    
<div id="kgw_frame">
	<div class="kgw_titleBox">
		<div class="kgw_iconBox">
               <img id="kgw_icon" src="./assets/q_icon.svg" alt="babo"></img>
          </div>
	    <div class="kgw_title">JavaScript 활용 웹 개발 인기…<br>“웹 개발자가 되고 싶어요!”</div>    
	</div>
       <div class="kgw_detail">
           <p class="kgw_author">라이너스 리(geek news)</p>
           <p class="kgw_divider">|</p>
           <p class="kgw_date">2024-10-30</p>
           <p class="kgw_theme">음식</p>
       </div>
</div>