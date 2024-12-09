<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    #kgw_frame {
        width: 800px;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
        gap: 12px;
        margin-top: 10px;
    }
    #kgw_qnum {
        color: #6B6B6B;
        font-size: 24px;
        width: 100%;
        padding-left: 10px;
    }
    .kgw_question {
        font-size: 24px;
        font-weight: 400;
        color: #000; 
    }
    .kgw_line {
        width: 100%;
        color: #9a9a9a;
    }
    .kgw_blankBox {
        width: 700px;
        border: 2px solid #D0D0D0;
        border-radius: 10px;
        display: flex;
        justify-content: flex-start;
        align-items: center;
        padding: 26px 24px;
        color: black;
        font-size: 24px;
    }
    .kgw_inputBox {
        width: 700px;
        height: 40px;
        display: flex;
        justify-content: flex-start;
        align-items: center;
        gap: 12px;
        margin-top: 10px;
    }
    .kgw_blankType {
        font-size: 24px;
        color: #965CB6;
    }      
    .kgw_fillBlank {
        width: 300px;
        height: 40px;
        border: 1px solid #D0D0D0;
        border-radius: 10px;
        padding-left: 14px;
        font-size: 16px;
    }
</style>    

<div id="kgw_frame">
    <p id="kgw_qnum">Q2</p>
    <div class="kgw_question">getElementById('title');는 ID가 'title'인 요소를 선택하는 올바른 방법이다.</div>
    <hr class="kgw_line">
    <div class="kgw_blankBox">
        AI 제품 개발 시 __(A)__ 와 __(B)__가 중요 요소로,<br>실패한 사례를 분석하여 모델을 개선하는 데 도움을 줍니다.
    </div>
    <div class="kgw_inputBox">
        <p class="kgw_blankType">A |</p>
        <input class="kgw_fillBlank" type="text" placeholder="A에 들어갈 단어를 작성하세요">
    </div>
    <div class="kgw_inputBox">
        <p class="kgw_blankType">B |</p>
        <input class="kgw_fillBlank" type="text" placeholder="B에 들어갈 단어를 작성하세요">
    </div>
</div>

 