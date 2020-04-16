<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <style>
        .container{
            display: flex;
            flex-direction: column;
        } 
        header{
            border-bottom:2px solid gray;
            padding-left:200px;
        }
        footer{
            border-top:1px solid gray;
            padding:20px;
            text-align: center; 
        }
        .content{
            display:flex;
        }
        .content nav{
            border-right:1px solid gray;
        }
        .content aside{
            border-left:1px solid gray;    
        }
        nav, aside{
            flex-basis: 100px;
            flex-shrink: 0;
        }
        main{
            padding:200px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>생활코딩</h1>
        </header>
        <section class="content">
            <nav>
                <ul>
                    <li>html</li>
                    <li>css</li>
                    <li>javascript</li>
                </ul>
            </nav>
            <main>
            	이곳은 컨텐츠 입니다.
            </main>
            <aside>
                AD
            </aside>
        </section>
        <footer>
            <a href="https://opentutorials.org/course/1">홈페이지</a>
        </footer>
    </div>
</body>
</html>
