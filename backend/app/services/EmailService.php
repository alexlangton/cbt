<?php

namespace App\Services;

use PHPMailer\PHPMailer\PHPMailer;

class EmailService {
    protected $mailer;
    protected $logger;
    protected $templatePath;

    public function __construct() {
        $f3 = \Base::instance();
        $this->logger = new \Logger($f3);
        $this->templatePath = $f3->get('TEMPLATE');
        
        $smtp = $f3->get('smtp');
        if (empty($smtp)) {
            throw new \Exception('Configuración SMTP no encontrada');
        }
        
        $this->initializeMailer($smtp, $f3->get('DEBUG'));
    }

    protected function initializeMailer($smtp, $debug) {
        $this->mailer = new PHPMailer(true);
        $this->mailer->isSMTP();
        $this->mailer->SMTPDebug = $debug ? 1 : 0;
        $this->mailer->Host = $smtp['host'];
        $this->mailer->SMTPAuth = (bool)$smtp['auth'];
        $this->mailer->Username = $smtp['user'];
        $this->mailer->Password = $smtp['pass'];
        $this->mailer->SMTPSecure = $smtp['secure'];
        $this->mailer->Port = (int)$smtp['port'];
        $this->mailer->CharSet = 'UTF-8';
        
        $this->mailer->Debugoutput = function($str, $level) {
            if ($level > 2) return;
            $this->logger->debug($str);
        };
    }

    public function enviarCorreoRecuperacion($email, $token) {
        try {
            $this->validarParametros($email, $token);
            $f3 = \Base::instance();
            
            $urlRecuperacion = $this->construirUrlRecuperacion($token);
            $fromEmail = $this->obtenerEmailRemitente();
            $body = $this->prepararCuerpoEmail($email, $urlRecuperacion);

            $this->configurarEmail($fromEmail, $email, $body);
            $resultado = $this->mailer->send();
            
            $this->registrarExito($email, $urlRecuperacion, $fromEmail);
            return $resultado;

        } catch (\Exception $e) {
            $this->registrarError($email, $e);
            throw $e;
        }
    }

    private function validarParametros($email, $token) {
        if (empty($email) || empty($token)) {
            throw new \InvalidArgumentException('Email y token son requeridos');
        }
    }

    private function construirUrlRecuperacion($token) {
        $f3 = \Base::instance();
        
        if (!$f3->exists('urls.BASE') || !$f3->exists('urls.PASSWORD_RESET')) {
            throw new \RuntimeException('Configuración de URLs incompleta');
        }
        
        $urlBase = rtrim($f3->get('urls.BASE'), '/');
        $rutaReset = ltrim($f3->get('urls.PASSWORD_RESET'), '/');
        return $urlBase . '/' . $rutaReset . '?token=' . urlencode($token);
    }

    private function obtenerEmailRemitente() {
        $f3 = \Base::instance();
        $fromEmail = $f3->get('smtp.from');
        
        if (empty($fromEmail)) {
            throw new \RuntimeException('Configuración de email (from) no encontrada');
        }
        
        return $fromEmail;
    }

    private function prepararCuerpoEmail($email, $urlRecuperacion) {
        $f3 = \Base::instance();
        $template = \Template::instance();
        
        $f3->set('url', $urlRecuperacion);
        $f3->set('email', $email);
        $f3->set('expiracion', '24 horas');
        $f3->set('app_nombre', $f3->get('APP_NOMBRE'));
        
        return $template->render('plantillas/template.html');
    }

    private function configurarEmail($fromEmail, $destinatario, $body) {
        $f3 = \Base::instance();
        $appNombre = $f3->get('APP_NOMBRE');
        
        $this->mailer->setFrom($fromEmail, $appNombre);
        $this->mailer->addAddress($destinatario);
        $this->mailer->isHTML(true);
        $this->mailer->Subject = $appNombre . ' - Recuperación de Contraseña';
        $this->mailer->Body = $body;
    }

    private function registrarExito($email, $url, $from) {
        $this->logger->info('Correo de recuperación enviado', [
            'email' => $email,
            'url' => $url,
            'from' => $from
        ]);
    }

    private function registrarError($email, \Exception $e) {
        $this->logger->error('Error al enviar correo de recuperación', [
            'email' => $email,
            'error' => $e->getMessage(),
            'trace' => $e->getTraceAsString()
        ]);
    }

    protected function renderizarPlantilla($datos) {
        if (!is_readable($this->templatePath)) {
            throw new \Exception("Template no accesible");
        }

        $plantilla = file_get_contents($this->templatePath);
        return $this->reemplazarVariables($plantilla, $datos);
    }

    protected function reemplazarVariables($contenido, $datos) {
        foreach ($datos as $clave => $valor) {
            $contenido = str_replace("{{{" . $clave . "}}}", $valor, $contenido);
        }
        return $contenido;
    }
} 