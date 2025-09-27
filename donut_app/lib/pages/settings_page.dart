import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Variables de estado usando setState
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  double _fontSize = 16.0;
  String _selectedLanguage = 'Español';
  int _selectedTheme = 0;

  // Lista de idiomas disponibles
  final List<String> _languages = ['Español', 'English', 'Français', 'Português'];
  
  // Lista de temas disponibles
  final List<String> _themes = ['Claro', 'Oscuro', 'Automático'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Sección de Notificaciones
          _buildSectionHeader('Notificaciones'),
          Card(
            child: SwitchListTile(
              title: const Text('Notificaciones Push'),
              subtitle: const Text('Recibe notificaciones sobre ofertas especiales'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                _showSnackBar('Notificaciones ${value ? 'activadas' : 'desactivadas'}');
              },
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Sección de Apariencia
          _buildSectionHeader('Apariencia'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Modo Oscuro'),
                  subtitle: const Text('Cambiar entre tema claro y oscuro'),
                  value: _darkModeEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                    _showSnackBar('Modo oscuro ${value ? 'activado' : 'desactivado'}');
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Tamaño de Fuente'),
                  subtitle: Text('${_fontSize.toInt()}px'),
                  trailing: SizedBox(
                    width: 200,
                    child: Slider(
                      value: _fontSize,
                      min: 12.0,
                      max: 24.0,
                      divisions: 12,
                      label: '${_fontSize.toInt()}px',
                      onChanged: (double value) {
                        setState(() {
                          _fontSize = value;
                        });
                      },
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Tema'),
                  subtitle: Text(_themes[_selectedTheme]),
                  trailing: DropdownButton<int>(
                    value: _selectedTheme,
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedTheme = newValue;
                        });
                        _showSnackBar('Tema cambiado a ${_themes[newValue]}');
                      }
                    },
                    items: _themes.asMap().entries.map((entry) {
                      return DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Sección de Idioma
          _buildSectionHeader('Idioma'),
          Card(
            child: ListTile(
              title: const Text('Idioma de la App'),
              subtitle: Text(_selectedLanguage),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedLanguage = newValue;
                    });
                    _showSnackBar('Idioma cambiado a $newValue');
                  }
                },
                items: _languages.map((String language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Sección de Datos
          _buildSectionHeader('Datos y Privacidad'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text('Limpiar Cache'),
                  subtitle: const Text('Liberar espacio de almacenamiento'),
                  onTap: () {
                    _showSnackBar('Cache limpiado');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.download),
                  title: const Text('Descargar Datos'),
                  subtitle: const Text('Exportar información de la cuenta'),
                  onTap: () {
                    _showSnackBar('Descarga iniciada');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.delete_forever),
                  title: const Text('Eliminar Cuenta'),
                  subtitle: const Text('Eliminar permanentemente la cuenta'),
                  onTap: () {
                    _showDeleteAccountDialog();
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Botones de acción
          _buildSectionHeader('Acciones'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.restore),
                  title: const Text('Restaurar Configuración'),
                  subtitle: const Text('Volver a la configuración por defecto'),
                  onTap: () {
                    _resetSettings();
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Acerca de la App'),
                  subtitle: const Text('Versión 1.0.0'),
                  onTap: () {
                    _showAboutDialog();
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Botón de guardar
          ElevatedButton.icon(
            onPressed: () {
              _saveSettings();
            },
            icon: const Icon(Icons.save),
            label: const Text('Guardar Configuración'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _resetSettings() {
    setState(() {
      _notificationsEnabled = true;
      _darkModeEnabled = false;
      _fontSize = 16.0;
      _selectedLanguage = 'Español';
      _selectedTheme = 0;
    });
    _showSnackBar('Configuración restaurada');
  }

  void _saveSettings() {
    // Aquí se guardarían las configuraciones en SharedPreferences o similar
    _showSnackBar('Configuración guardada');
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Cuenta'),
          content: const Text(
            '¿Estás seguro de que quieres eliminar tu cuenta? Esta acción no se puede deshacer.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar('Cuenta eliminada');
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Donut App',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.local_dining,
        size: 50,
        color: Colors.blue,
      ),
      children: [
        const Text('Una aplicación deliciosa para pedir donas y más.'),
        const SizedBox(height: 16),
        const Text('Desarrollado con Flutter'),
      ],
    );
  }
}


