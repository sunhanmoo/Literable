<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
    #jh_landing_div {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin: 0;
        padding: 0;
        width: 100%;
        height: auto; 
        overflow: hidden;
    }

    #jh_landing_div img {
        width: 100%; 
        height: auto;
        object-fit: cover;
    }
</style>

<div id="jh_landing_div">
		<img id="jh_landing_div" src="./assets/1.jpg"/>
		<img id="jh_landing_div" src="./assets/2.jpg"/>
		<img id="jh_landing_div" src="./assets/3.jpg"/>
		<img id="jh_landing_div" src="./assets/4.jpg"/>
		<img id="jh_landing_div" src="./assets/5.jpg"/>
</div>

<script>
    window.addEventListener('scroll', function() {
        if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
            window.location.href = 'index.jsp?page=login_page';
        }
    });
</script>
