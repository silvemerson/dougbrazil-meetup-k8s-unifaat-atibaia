# Kubernetes: o que é esse negócio que todo mundo fala

Slides da palestra apresentada no **DOUGBR Meetup** na [UNIFAAT](https://www.unifaat.com.br/) — Atibaia/SP.

---

<img src="logos-dougbr/fundo-transparente.png" height="200">


## Whoami

**Emerson Silva**

- Engenheiro DevOps/SRE na **4Linux**
- +9 anos em ambientes DevOps críticos
- Foco em **Kubernetes**, IaC e confiabilidade
- Escritor, instrutor e palestrante ativo na comunidade
- Autor: *Kubernetes para Iniciantes* e *Mentes Automatizadas*
- Blog: [emerson-silva.blog.br](https://emerson-silva.blog.br)

---

## O que será visto na palestra

1. **A evolução** — bare metal → VMs → containers e o problema de escala
2. **Como surgiu o Kubernetes** — do Google Borg ao open source em 2014
3. **O que é e como funciona** — arquitetura, Control Plane e Worker Nodes
4. **Quando usar** — cenários ideais e quando o K8s é overkill
5. **Vantagens** — self-healing, auto-scaling, rolling updates e portabilidade
6. **Principais objetos** — Pod, Deployment, Service, Namespace, ConfigMap e Secret
7. **Deploy na prática** — Snake Classic rodando dentro de um cluster kind
8. **Certificações** — KCNA, KCSA, CKAD, CKA, CKS e o título KubeAstronaut

---

## Como usar os slides

### Pré-requisito

```bash
npm install -g @marp-team/marp-cli
```

### Visualizar no browser com live reload

```bash
marp --watch kubernetes-para-iniciantes.md
```

### Exportar para PDF

```bash
marp kubernetes-para-iniciantes.md --pdf --allow-local-files -o kubernetes-para-iniciantes.pdf
```

> `--allow-local-files` é necessário para carregar imagens e logos locais.

### Exportar para HTML

```bash
marp kubernetes-para-iniciantes.md --html --allow-local-files -o kubernetes-para-iniciantes.html
```

---

## Demo: Snake Classic no Kubernetes

A demo usa [kind](https://kind.sigs.k8s.io/) para subir um cluster local com port mapping já configurado.

### Pré-requisitos

- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Docker rodando

### Subir tudo com um comando

```bash
cd kind
./setup.sh
# acesse http://localhost:8080
```

### Ou passo a passo

```bash
# cria o cluster com port mapping 30080 → localhost:8080
kind create cluster --config kind/cluster.yaml

# aplica Deployment e Service
kubectl apply -f kind/snake.yaml

# acompanha o pod subindo
kubectl get pods -w

# acessa o jogo
# http://localhost:8080
```

### Encerrar

```bash
cd kind
./teardown.sh
```

### Estrutura da pasta kind

```
kind/
├── cluster.yaml        # configuração do cluster (1 control-plane + 2 workers)
├── snake.yaml          # Deployment + Service do snake-classic
├── setup.sh            # sobe cluster e faz deploy automaticamente
├── teardown.sh         # remove o cluster
└── snake-classic/      # submódulo — github.com/silvemerson/snake-classic
```

> Para clonar incluindo o submódulo: `git clone --recurse-submodules <repo>`

---

## Recursos

- Documentação oficial: [kubernetes.io/docs](https://kubernetes.io/docs)
- Labs interativos gratuitos: [killercoda.com](https://killercoda.com)
- Certificações CNCF: [training.linuxfoundation.org](https://training.linuxfoundation.org)
- Blog do autor: [emerson-silva.blog.br](https://emerson-silva.blog.br)
