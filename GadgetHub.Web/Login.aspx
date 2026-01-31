<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GadgetHub.Web.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Login - Gadget Hub</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');

        :root {
            --bg-gradient: linear-gradient(160deg, #0f172a 0%, #1e3a8a 50%, #22d3ee 100%);
            --card-bg: rgba(15, 23, 42, 0.78);
            --panel-bg: rgba(248, 250, 255, 0.96);
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --accent: #22d3ee;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --radius-lg: 24px;
            --radius-sm: 12px;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--bg-gradient);
            background-size: 200% 200%;
            animation: gradientShift 22s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 24px;
            color: var(--text-dark);
            position: relative;
            overflow: hidden;
        }

        #bgCanvas {
            position: fixed;
            inset: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            pointer-events: none;
        }

        .bg-rings {
            position: absolute;
            width: 1400px;
            height: 1400px;
            border-radius: 50%;
            top: -680px;
            right: -620px;
            background: radial-gradient(circle, rgba(255,255,255,0.12) 0%, rgba(15,23,42,0) 55%);
            border: 1px solid rgba(255,255,255,0.08);
            filter: blur(0.2px);
            z-index: 0;
            animation: rotate 40s linear infinite;
        }

        .bg-rings::after {
            content: '';
            position: absolute;
            inset: 80px;
            border-radius: 50%;
            border: 1px solid rgba(255,255,255,0.08);
        }

        .bg-blur {
            position: absolute;
            width: 420px;
            height: 420px;
            border-radius: 50%;
            background: rgba(14, 165, 233, 0.28);
            top: 18%;
            left: -120px;
            filter: blur(120px);
            z-index: 0;
            animation: float 16s ease-in-out infinite;
        }

        .bg-grid {
            position: absolute;
            inset: -120px;
            background-image:
                linear-gradient(90deg, rgba(255,255,255,0.05) 1px, transparent 1px),
                linear-gradient(rgba(255,255,255,0.05) 1px, transparent 1px);
            background-size: 140px 140px;
            opacity: 0.6;
            mask-image: radial-gradient(circle at center, rgba(0,0,0,0.8), transparent 75%);
            mix-blend-mode: screen;
            z-index: 0;
            animation: drift 28s linear infinite;
        }

        #form1 {
            width: min(860px, 100%);
            display: flex;
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            box-shadow: 0 32px 80px rgba(15, 23, 42, 0.35);
            overflow: hidden;
            backdrop-filter: blur(22px);
            position: relative;
            z-index: 2;
            border: 1px solid rgba(148, 163, 184, 0.18);
        }

        .brand-panel {
            flex: 1.1;
            background: linear-gradient(160deg, rgba(248, 250, 255, 0.18) 0%, rgba(15, 23, 42, 0.35) 100%);
            padding: 48px 44px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 18px;
            color: #e2e8f0;
            position: relative;
        }

        .brand-panel::after {
            content: '';
            position: absolute;
            inset: 16px;
            border-radius: 18px;
            border: 1px solid rgba(148, 163, 184, 0.12);
            pointer-events: none;
        }

        .brand-badge {
            background: rgba(37, 99, 235, 0.14);
            color: #e0f2fe;
            padding: 6px 16px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        .brand-title {
            font-size: 30px;
            font-weight: 700;
            line-height: 1.25;
            margin: 0;
        }

        .brand-subtitle {
            margin: 0;
            font-size: 15px;
            max-width: 320px;
            color: rgba(226, 232, 240, 0.82);
        }

        .form-panel {
            flex: 1;
            background: var(--panel-bg);
            padding: 52px 56px;
            display: flex;
            flex-direction: column;
            gap: 22px;
            justify-content: center;
        }

        .form-panel h2 {
            margin: 0;
            font-size: 28px;
            font-weight: 700;
            color: var(--text-dark);
        }

        .form-panel p {
            margin: 0;
            color: var(--text-muted);
            font-size: 15px;
        }

        .input-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        label {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-dark);
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 13px 16px;
            border-radius: var(--radius-sm);
            border: 1px solid rgba(148, 163, 184, 0.35);
            font-size: 15px;
            transition: border 0.2s ease, box-shadow 0.2s ease;
            background: rgba(255, 255, 255, 0.95);
            color: var(--text-dark);
            box-shadow: 0 1px 2px rgba(15, 23, 42, 0.04);
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: rgba(37, 99, 235, 0.6);
            outline: none;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.14);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, #1d4ed8 100%);
            color: #f8fafc;
            border: none;
            border-radius: var(--radius-sm);
            padding: 14px 18px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.18s ease, box-shadow 0.28s ease;
            width: 100%;
            position: relative;
            overflow: hidden;
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 14px 32px rgba(37, 99, 235, 0.25);
        }

        .btn-primary::after {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(120deg, transparent, rgba(255, 255, 255, 0.26), transparent);
            transform: translateX(-110%);
            transition: transform 0.4s ease;
        }

        .btn-primary:hover::after {
            transform: translateX(110%);
        }

        .form-footer {
            display: flex;
            flex-direction: column;
            gap: 10px;
            font-size: 14px;
            text-align: center;
        }

        .register-link {
            color: var(--primary);
            font-weight: 600;
            text-decoration: none;
            transition: color 0.2s;
        }

        .register-link:hover {
            color: var(--primary-hover);
        }

        #lblStatus {
            font-weight: 600;
            text-align: center;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        @keyframes float {
            0%, 100% { transform: translate3d(0, 0, 0); }
            50% { transform: translate3d(0, -30px, 0); }
        }

        @keyframes drift {
            from { background-position: 0 0, 0 0; }
            to { background-position: 140px 0, 0 140px; }
        }

        @media (max-width: 720px) {
            #form1 {
                flex-direction: column;
            }

            .brand-panel {
                padding: 34px 28px 24px;
                align-items: flex-start;
                text-align: left;
                gap: 14px;
            }

            .brand-subtitle {
                max-width: none;
            }

            .form-panel {
                padding: 34px 26px 44px;
            }
        }
    </style>
</head>
<body>
    <canvas id="bgCanvas"></canvas>
    <span class="bg-rings"></span>
    <span class="bg-blur"></span>
    <span class="bg-grid"></span>
    <form id="form1" runat="server">
        <section class="brand-panel">
            <span class="brand-badge">Welcome back</span>
            <h1 class="brand-title">Access your Gadget Hub workspace</h1>
            <p class="brand-subtitle">Monitor orders, inventory, and customers in one streamlined dashboard designed for every member of your team.</p>
        </section>
        <section class="form-panel">
            <div>
                <h2>Sign in</h2>
                <p>Continue with your email credentials.</p>
            </div>

            <div class="input-group">
                <asp:Label ID="lblEmail" runat="server" Text="Email" AssociatedControlID="txtEmail" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="input" Placeholder="you@example.com" />
            </div>

            <div class="input-group">
                <asp:Label ID="lblPassword" runat="server" Text="Password" AssociatedControlID="txtPassword" />
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input" Placeholder="Enter your password" />
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-primary" OnClick="btnLogin_Click" />

            <asp:Label ID="lblStatus" runat="server" Text="" ForeColor="Red" />

            <div class="form-footer">
                <asp:Literal runat="server" ID="litRegisterText"></asp:Literal>
                <asp:HyperLink runat="server" ID="hlRegister" NavigateUrl="~/Register.aspx" Text="Register now" CssClass="register-link" />
            </div>
        </section>
    </form>
    <script>
        (function () {
            const canvas = document.getElementById('bgCanvas');
            const ctx = canvas.getContext('2d');
            const particles = [];
            const particleCount = 36;

            function resize() {
                canvas.width = window.innerWidth;
                canvas.height = window.innerHeight;
            }

            function createParticles() {
                particles.length = 0;
                for (let i = 0; i < particleCount; i++) {
                    particles.push({
                        x: Math.random() * canvas.width,
                        y: Math.random() * canvas.height,
                        radius: 2 + Math.random() * 3,
                        alpha: 0.2 + Math.random() * 0.5,
                        speed: 0.3 + Math.random() * 0.7,
                        angle: Math.random() * Math.PI * 2
                    });
                }
            }

            function draw() {
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.fillStyle = '#ffffff';

                particles.forEach(p => {
                    p.x += Math.cos(p.angle) * p.speed;
                    p.y += Math.sin(p.angle) * p.speed;

                    if (p.x < -50) p.x = canvas.width + 50;
                    if (p.x > canvas.width + 50) p.x = -50;
                    if (p.y < -50) p.y = canvas.height + 50;
                    if (p.y > canvas.height + 50) p.y = -50;

                    ctx.globalAlpha = p.alpha;
                    ctx.beginPath();
                    ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
                    ctx.fill();
                });

                requestAnimationFrame(draw);
            }

            window.addEventListener('resize', () => {
                resize();
                createParticles();
            });

            resize();
            createParticles();
            draw();
        })();
    </script>
</body>
</html>
