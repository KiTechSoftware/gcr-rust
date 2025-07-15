# 🦀 GCR Rust Security Tools

A lightweight, CI-ready Docker image for Rust security and packaging tools — maintained by [Kitech Software](https://github.com/kitechsoftware).

Hosted on GitHub Container Registry:  
👉 [`ghcr.io/kitechsoftware/gcr-rust`](https://github.com/kitechsoftware/gcr-rust/pkgs/container/gcr-rust)

---

## 🚀 What's Inside

This image is designed for security scanning, cross-compilation, and packaging Rust applications in CI/CD.

### ✅ Included Tools

| Tool                  | Purpose |
|-----------------------|---------|
| `cargo audit`         | Check for vulnerable crates (RustSec) |
| `cargo geiger`        | Detect `unsafe` code |
| `cargo deny`          | Enforce license & dependency policy |
| `cargo deb`           | Build `.deb` packages |
| `cargo generate-rpm`  | Build `.rpm` packages |
| `gcc-aarch64-linux-gnu` | Cross-compile to `aarch64` |

---

## 📂 Scripts Included

The following scripts are pre-installed in `/usr/local/bin`:

| Script                 | Description |
|------------------------|-------------|
| `unsafe-scan.sh`       | Runs `cargo geiger`, formats and summarizes unsafe code |
| `audit-deps.sh`        | Runs `cargo audit` with Markdown output |
| `cargo-deny.sh`        | Runs `cargo deny check`, checks policy violations |
| `security-check-all.sh`| Runs all of the above, creates combined summary/report |

> All scripts support the `--no-fail` flag to allow soft enforcement.

---

## 🧪 Example GitHub Actions Usage

```yaml
jobs:
  security:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/kitechsoftware/gcr-rust:latest

    steps:
      - uses: actions/checkout@v4

      - name: Run All Security Checks
        run: security-check-all.sh --no-fail

      - name: Upload Security Report
        uses: actions/upload-artifact@v4
        with:
          name: security-summary
          path: security-summary.md
```

---

## 🖥️ Local Usage

You can also run the tools locally with Docker:

```bash
docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ghcr.io/kitechsoftware/gcr-rust:latest security-check-all.sh
```

---

## 🛠️ Building the Image Locally

```bash
docker build -t gcr-rust -f .docker/Dockerfile.security .
```

---

## 🤝 Contributing

Contributions are welcome! Feel free to submit issues, pull requests, or ideas.

---

## 📄 License

[MIT](LICENSE)

