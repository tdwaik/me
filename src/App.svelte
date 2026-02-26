<!-- src/App.svelte -->
<script lang="ts">
  const name = "Thaer Aldwaik";
  const role = "Senior Backend Engineer";
  const location = "Washington State, USA";

  const highlights = [
    "Identity & Auth: SSO/OIDC, FusionAuth, platform integrations",
    "Cloud & DevOps: AWS, CI/CD, Terraform, containers, Kubernetes",
    "Engineering: .NET/C#, Java, React, secure-by-default systems",
  ];

  const links = [
    { label: "GitHub", href: "https://github.com/tdwaik" },
    { label: "LinkedIn", href: "https://www.linkedin.com/in/tdwaik/" },
    { label: "Email", href: "mailto:me@thaer.dev" },
    { label: "Resume", href: "/resume.pdf" },
  ];

  const skills = [
    "C# / .NET",
    "AWS",
    "Terraform",
    "Kubernetes",
    "OIDC / SSO",
    "Security",
    "Java",
    "React",
    "PostgreSQL",
    "Redis/Valkey",
    "GitHub Actions",
    "Observability",
  ];

  const projects = [
    {
      title: "Local-first AI Assistant (Tauri + Svelte)",
      description:
        "A privacy-first desktop assistant with persistent memory, multi-tool integration, and agent-level actions.",
      tags: ["Tauri", "Svelte", "Rust", "Local-first"],
      href: "#",
    },
    {
      title: "Identity Platform Modernization",
      description:
        "SSO improvements, OIDC integrations, and secure session/culture middleware across a multi-app ecosystem.",
      tags: [".NET", "OIDC", "Security"],
      href: "#",
    },
    {
      title: "CI/CD & Infra as Code",
      description:
        "Standardized environments with Terraform, automated deployments, and safer releases via GitHub workflows.",
      tags: ["Terraform", "AWS", "CI/CD"],
      href: "#",
    },
    {
      title: "Track Car Build (Spec E46)",
      description:
        "A long-term project: engineering decisions, safety, setup iterations, data-driven improvements.",
      tags: ["Motorsports", "DIY", "Data"],
      href: "#",
    },
  ];

  const experience = [
    {
      title: "Senior Backend Engineer — Identity / Auth",
      company: "Siteimprove",
      period: "2023 — Present",
      bullets: [
        "Built and maintained authentication/SSO flows across internal and third-party apps.",
        "Improved reliability and security posture (tokens, sessions, middleware, policies).",
        "Worked with CI/CD and infra teams to standardize deployments and environments.",
      ],
    },
    {
      title: "Backend Engineer",
      company: "Previous Company",
      period: "2020 — 2023",
      bullets: [
        "Delivered APIs, services, and integrations with strong observability and testing.",
        "Worked on performance improvements and production hardening.",
      ],
    },
  ];

  const year = new Date().getFullYear();

  function scrollToId(id: string) {
    const el = document.getElementById(id);
    el?.scrollIntoView({ behavior: "smooth", block: "start" });
  }
</script>

<div class="min-h-screen bg-surface text-ink selection:bg-white/10 selection:text-white">
  <!-- Background decoration -->
  <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
    <div class="absolute -top-40 left-1/2 h-[520px] w-[520px] -translate-x-1/2 rounded-full bg-gradient-to-tr from-accent/30 to-fuchsia-500/20 blur-3xl"></div>
    <div class="absolute -bottom-48 right-[-120px] h-[520px] w-[520px] rounded-full bg-gradient-to-tr from-cyan-500/15 to-accent/20 blur-3xl"></div>
    <div class="absolute inset-0 bg-grid opacity-[0.12]"></div>
  </div>

  <!-- Top Nav -->
  <header class="sticky top-0 z-40 backdrop-blur supports-[backdrop-filter]:bg-surface/65 bg-surface/80 border-b border-white/10">
    <div class="mx-auto max-w-6xl px-4">
      <div class="flex h-16 items-center justify-between">
        <button
          class="group inline-flex items-center gap-2 rounded-xl px-3 py-2 hover:bg-white/5 transition"
          on:click={() => scrollToId("top")}
          aria-label="Go to top"
        >
          <span class="h-2.5 w-2.5 rounded-full bg-accent shadow-[0_0_18px_rgba(99,102,241,0.8)]"></span>
          <span class="font-semibold tracking-tight">{name}</span>
          <span class="hidden sm:inline text-white/55">• {role}</span>
        </button>

        <nav class="hidden md:flex items-center gap-1 text-sm">
          <button class="navbtn" on:click={() => scrollToId("projects")}>Projects</button>
          <button class="navbtn" on:click={() => scrollToId("skills")}>Skills</button>
          <button class="navbtn" on:click={() => scrollToId("experience")}>Experience</button>
          <button class="navbtn" on:click={() => scrollToId("contact")}>Contact</button>
        </nav>

        <div class="flex items-center gap-2">
          <a class="btn btn-ghost hidden sm:inline-flex" href={links[0].href} target="_blank" rel="noreferrer">
            GitHub
          </a>
          <a class="btn btn-primary" href={links[2].href}>Email me</a>
        </div>
      </div>
    </div>
  </header>

  <main id="top" class="mx-auto max-w-6xl px-4">
    <!-- Hero -->
    <section class="pt-14 pb-10">
      <div class="grid gap-8 lg:grid-cols-[1.2fr_0.8fr] items-start">
        <div>
          <p class="inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/5 px-3 py-1 text-xs text-white/70">
            <span class="h-1.5 w-1.5 rounded-full bg-emerald-400"></span>
            Available for interesting projects • {location}
          </p>

          <h1 class="mt-5 text-4xl sm:text-5xl font-semibold tracking-tight leading-[1.08]">
            Building secure, scalable platforms —
            <span class="text-white/70">with a bias for clean systems.</span>
          </h1>

          <p class="mt-5 text-base sm:text-lg text-white/70 max-w-2xl">
            I’m {name}, a {role} focused on identity, security, and production-grade systems.
            I like turning complex constraints into simple, maintainable solutions.
          </p>

          <div class="mt-7 flex flex-wrap gap-3">
            <button class="btn btn-primary" on:click={() => scrollToId("projects")}>View projects</button>
            <a class="btn btn-ghost" href={links[3].href}>Download resume</a>
            <a class="btn btn-ghost" href={links[1].href} target="_blank" rel="noreferrer">LinkedIn</a>
          </div>

          <div class="mt-8 grid gap-3 sm:grid-cols-3">
            {#each highlights as h}
              <div class="card p-4">
                <p class="text-sm text-white/75 leading-relaxed">{h}</p>
              </div>
            {/each}
          </div>
        </div>

        <!-- Profile card -->
        <aside class="card p-6">
          <div class="flex items-center gap-4">
            <div class="h-14 w-14 rounded-2xl bg-white/5 border border-white/10 flex items-center justify-center">
              <span class="text-xl font-semibold">{name.split(" ").map(n => n[0]).join("")}</span>
            </div>
            <div>
              <p class="font-semibold">{name}</p>
              <p class="text-sm text-white/65">{role}</p>
            </div>
          </div>

          <div class="mt-6 space-y-3">
            <div class="flex items-center justify-between text-sm">
              <span class="text-white/60">Focus</span>
              <span class="text-white/80">Identity • Cloud • Security</span>
            </div>
            <div class="flex items-center justify-between text-sm">
              <span class="text-white/60">Stack</span>
              <span class="text-white/80">.NET • AWS • Terraform</span>
            </div>
            <div class="flex items-center justify-between text-sm">
              <span class="text-white/60">Location</span>
              <span class="text-white/80">{location}</span>
            </div>
          </div>

          <div class="mt-6 grid grid-cols-2 gap-2">
            {#each links as l}
              <a class="chip" href={l.href} target={l.href.startsWith("http") ? "_blank" : undefined} rel="noreferrer">
                {l.label}
                <span class="ml-auto text-white/35">↗</span>
              </a>
            {/each}
          </div>

          <p class="mt-5 text-xs text-white/50 leading-relaxed">
            Tip: Replace links + projects with real URLs. Add a headshot by swapping the initials block with an image.
          </p>
        </aside>
      </div>
    </section>

    <!-- Projects -->
    <section id="projects" class="py-10">
      <div class="flex items-end justify-between gap-4">
        <div>
          <h2 class="section-title">Projects</h2>
          <p class="section-subtitle">A few things I’ve built (or I’m building).</p>
        </div>
        <button class="btn btn-ghost hidden sm:inline-flex" on:click={() => scrollToId("contact")}>
          Work with me
        </button>
      </div>

      <div class="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {#each projects as p}
          <a class="card p-5 hover:border-white/20 transition group" href={p.href} target={p.href.startsWith("http") ? "_blank" : undefined} rel="noreferrer">
            <div class="flex items-start justify-between gap-3">
              <h3 class="font-semibold tracking-tight">{p.title}</h3>
              <span class="text-white/35 group-hover:text-white/55 transition">↗</span>
            </div>
            <p class="mt-2 text-sm text-white/70 leading-relaxed">{p.description}</p>
            <div class="mt-4 flex flex-wrap gap-2">
              {#each p.tags as t}
                <span class="tag">{t}</span>
              {/each}
            </div>
          </a>
        {/each}
      </div>
    </section>

    <!-- Skills -->
    <section id="skills" class="py-10">
      <h2 class="section-title">Skills</h2>
      <p class="section-subtitle">Tools I reach for often.</p>

      <div class="mt-6 card p-5">
        <div class="flex flex-wrap gap-2">
          {#each skills as s}
            <span class="tag">{s}</span>
          {/each}
        </div>
      </div>
    </section>

    <!-- Experience -->
    <section id="experience" class="py-10">
      <h2 class="section-title">Experience</h2>
      <p class="section-subtitle">What I’ve done professionally.</p>

      <div class="mt-6 space-y-4">
        {#each experience as e}
          <div class="card p-6">
            <div class="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-2">
              <div>
                <h3 class="font-semibold tracking-tight">{e.title}</h3>
                <p class="text-sm text-white/70">{e.company}</p>
              </div>
              <p class="text-sm text-white/55">{e.period}</p>
            </div>

            <ul class="mt-4 space-y-2 text-sm text-white/75">
              {#each e.bullets as b}
                <li class="flex gap-2">
                  <span class="mt-[7px] h-1.5 w-1.5 rounded-full bg-white/35 flex-none"></span>
                  <span>{b}</span>
                </li>
              {/each}
            </ul>
          </div>
        {/each}
      </div>
    </section>

    <!-- Contact -->
    <section id="contact" class="py-10 pb-16">
      <div class="card p-7">
        <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-6">
          <div>
            <h2 class="text-2xl font-semibold tracking-tight">Let’s build something.</h2>
            <p class="mt-2 text-white/70 max-w-xl">
              Want to collaborate or hire me? Send a quick note with what you’re building and what “success” looks like.
            </p>
          </div>

          <div class="flex flex-wrap gap-3">
            <a class="btn btn-primary" href={links[2].href}>Email me</a>
            <a class="btn btn-ghost" href={links[1].href} target="_blank" rel="noreferrer">LinkedIn</a>
            <a class="btn btn-ghost" href={links[0].href} target="_blank" rel="noreferrer">GitHub</a>
          </div>
        </div>
      </div>
    </section>

    <footer class="pb-10 text-center text-xs text-white/45">
      © {year} {name}. Built with Svelte + Tailwind.
    </footer>
  </main>
</div>