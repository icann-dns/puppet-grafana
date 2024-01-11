require 'spec_helper'

describe 'grafana::settings::paths' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults for all parameters' do
        let(:pre_condition) do
          "class { '::grafana': }"
        end

        it do
          is_expected.to contain_grafana__settings('paths')
            .with(
              'settings' => {
                'data'         => nil,
                'logs'         => nil,
                'plugins'      => nil,
                'provisioning' => '/etc/grafana/provisioning',
              },
            )
        end

        ['', 'dashboards', 'datasources'].each do |file|
          it do
            is_expected.to contain_file("/etc/grafana/provisioning/#{file}")
              .with(
                'ensure'  => 'directory',
                'owner'   => 'root',
                'group'   => 'grafana',
                'mode'    => '0755',
              )
          end
        end
      end

      context 'with defaults for all parameters and a custom config_dir' do
        let(:pre_condition) do
          "class { '::grafana':
             config_dir => '/etc/foo',
           }"
        end

        it do
          is_expected.to contain_grafana__settings('paths')
            .with(
              'settings' => {
                'data'         => nil,
                'logs'         => nil,
                'plugins'      => nil,
                'provisioning' => '/etc/foo/provisioning',
              },
            )
        end

        ['', 'dashboards', 'datasources'].each do |file|
          it do
            is_expected.to contain_file("/etc/foo/provisioning/#{file}")
              .with(
                'ensure'  => 'directory',
                'owner'   => 'root',
                'group'   => 'grafana',
                'mode'    => '0755',
              )
          end
        end
      end

      context 'with custom parameters' do
        let(:pre_condition) do
          "class { '::grafana': }"
        end

        let(:params) do
          {
            'data'         => '/etc/custom1/data',
            'logs'         => '/etc/custom2/logs',
            'plugins'      => '/etc/custom3/plugins',
            'provisioning' => '/etc/custom4/provisioning',
          }
        end

        it do
          is_expected.to contain_grafana__settings('paths')
            .with(
              'settings' => {
                'data'         => '/etc/custom1/data',
                'logs'         => '/etc/custom2/logs',
                'plugins'      => '/etc/custom3/plugins',
                'provisioning' => '/etc/custom4/provisioning',
              },
            )
        end

        ['', 'dashboards', 'datasources'].each do |file|
          it do
            is_expected.to contain_file("/etc/custom4/provisioning/#{file}")
              .with(
                'ensure'  => 'directory',
                'owner'   => 'root',
                'group'   => 'grafana',
                'mode'    => '0755',
              )
          end
        end
      end
    end
  end
end
