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
6. **Certificações** — CKAD, CKA e CKS explicadas
7. **Principais objetos** — Pod, Deployment, Service, Namespace, ConfigMap e Secret
8. **Deploy na prática** — Super Mario Bros rodando dentro de um cluster

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

## Demo: Super Mario no Kubernetes

Os manifestos usados no deploy ao vivo estão inline na apresentação. Para reproduzir:

```bash
# inicia um cluster local
minikube start

# aplica os manifestos
kubectl apply -f supermario.yaml
kubectl apply -f supermario-service.yaml

# acompanha o pod subindo
kubectl get pods -w

# acessa o jogo no navegador
kubectl port-forward service/supermario 8080:80
# http://localhost:8080
```

---

## Recursos

- Documentação oficial: [kubernetes.io/docs](https://kubernetes.io/docs)
- Labs interativos gratuitos: [killercoda.com](https://killercoda.com)
- Certificações CNCF: [training.linuxfoundation.org](https://training.linuxfoundation.org)
- Blog do autor: [emerson-silva.blog.br](https://emerson-silva.blog.br)
